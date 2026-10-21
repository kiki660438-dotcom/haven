"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export type OrderActionState = { ok: boolean; error?: string } | null;

type EditPayload = {
  created_at_local: string;
  total: number;
  payment_method: "cash" | "transfer" | "none";
  items: {
    service_id: string | null;
    service_name: string;
    price: number;
    quantity: number;
    unit_cost: number | null;
  }[];
};

const int = (v: unknown) => Math.max(0, Math.floor(Number(v) || 0));

function refresh() {
  revalidatePath("/orders");
  revalidatePath("/revenue");
  revalidatePath("/members");
  revalidatePath("/dashboard");
}

// 改訂單：日期時間、各項目（名稱／單價／數量）、實收金額、付款方式。
// 實收金額由你自己輸入（有些訂單的項目是商品券抵的，項目合計會比實收多），
// 這裡不會動商品券堂數和材料庫存
export async function updateOrder(
  id: string,
  _prev: OrderActionState,
  formData: FormData
): Promise<OrderActionState> {
  let payload: EditPayload;
  try {
    payload = JSON.parse(String(formData.get("payload") ?? ""));
  } catch {
    return { ok: false, error: "資料格式錯誤，請重新整理後再試" };
  }

  const items = (payload.items ?? [])
    .map((i) => ({
      service_id: i.service_id || null,
      service_name: String(i.service_name ?? "").trim(),
      price: int(i.price),
      quantity: Math.min(Math.max(int(i.quantity), 1), 99),
      unit_cost: i.unit_cost ?? null,
    }))
    .filter((i) => i.service_name);
  if (items.length === 0) return { ok: false, error: "至少要有一項消費項目" };

  if (!/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$/.test(payload.created_at_local ?? "")) {
    return { ok: false, error: "日期時間格式不正確" };
  }

  const total = int(payload.total);
  const method = payload.payment_method === "cash" || payload.payment_method === "transfer" ? payload.payment_method : null;

  const supabase = await createClient();
  const update: Record<string, unknown> = {
    created_at: `${payload.created_at_local}:00+08:00`,
    total,
    payment_method: method,
  };
  // 選了現金或匯款，就視為已收款；選「不收費」則維持原本狀態
  if (method) update.status = "paid";

  const { error } = await supabase.from("orders").update(update).eq("id", id);
  if (error) return { ok: false, error: `更新失敗：${error.message}` };

  await supabase.from("order_items").delete().eq("order_id", id);
  const { error: itemError } = await supabase
    .from("order_items")
    .insert(items.map((i) => ({ ...i, order_id: id })));
  if (itemError) return { ok: false, error: `項目更新失敗：${itemError.message}` };

  refresh();
  return { ok: true };
}

// 刪除訂單：把這筆開單時扣掉的材料庫存加回去，並讓預約回到「已確認」（可以重新開單）。
// 商品券不會自動退還：這筆如果有「扣一堂」或「購買商品券」，要到商品券頁面自己調整
export async function deleteOrder(id: string) {
  const supabase = await createClient();

  const { data: order } = await supabase
    .from("orders")
    .select("id, appointment_id, order_items(service_id, quantity)")
    .eq("id", id)
    .maybeSingle();
  if (!order) return;

  const serviceIds = [...new Set((order.order_items ?? []).map((i) => i.service_id).filter((s): s is string => !!s))];
  if (serviceIds.length > 0) {
    const [{ data: recipes }, { data: services }] = await Promise.all([
      supabase.from("service_products").select("service_id, product_id, quantity").in("service_id", serviceIds),
      supabase.from("services").select("id, total_sessions").in("id", serviceIds),
    ]);
    const isPackage = new Set((services ?? []).filter((s) => s.total_sessions).map((s) => s.id));
    const addBack = new Map<string, number>();
    for (const item of order.order_items ?? []) {
      if (!item.service_id || isPackage.has(item.service_id)) continue;
      for (const r of (recipes ?? []).filter((x) => x.service_id === item.service_id)) {
        addBack.set(r.product_id, (addBack.get(r.product_id) ?? 0) + r.quantity * item.quantity);
      }
    }
    if (addBack.size > 0) {
      const { data: products } = await supabase
        .from("products")
        .select("id, stock_quantity")
        .in("id", [...addBack.keys()]);
      for (const p of products ?? []) {
        await supabase
          .from("products")
          .update({ stock_quantity: Math.round(p.stock_quantity + (addBack.get(p.id) ?? 0)) })
          .eq("id", p.id);
      }
    }
  }

  await supabase.from("orders").delete().eq("id", id);

  if (order.appointment_id) {
    await supabase
      .from("appointments")
      .update({ status: "confirmed" })
      .eq("id", order.appointment_id)
      .eq("status", "completed");
    revalidatePath("/appointments");
    revalidatePath("/appointments/calendar");
  }
  refresh();
}
