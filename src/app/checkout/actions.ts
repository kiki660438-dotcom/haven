"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { useSession as deductVoucherSession } from "../vouchers/actions";

type OrderLine = {
  service_id: string | null;
  name: string;
  price: number;
  qty: number;
  discount: number;
  voucher_id: string | null;
  use_now?: boolean;
};

type OrderPayload = {
  appointment_id: string | null;
  customer_id: string | null;
  customer_name: string | null;
  staff_id: string | null;
  record?: string;
  cash: number;
  transfer: number;
  lines: OrderLine[];
};

const int = (v: unknown) => Math.max(0, Math.floor(Number(v) || 0));

function fail(appointmentId: string | null, message: string): never {
  const back = appointmentId ? `appointment=${appointmentId}&` : "";
  redirect(`/checkout?${back}error=${encodeURIComponent(message)}`);
}

export async function createOrder(formData: FormData) {
  const supabase = await createClient();

  let payload: OrderPayload;
  try {
    payload = JSON.parse(String(formData.get("payload") ?? ""));
  } catch {
    throw new Error("開單資料格式錯誤，請重新整理後再試");
  }
  const appointment_id = payload.appointment_id || null;
  const customer_id = payload.customer_id || null;
  const customer_name = payload.customer_name?.trim() || null;
  const staff_id = payload.staff_id || null;
  const cash = int(payload.cash);
  const transfer = int(payload.transfer);

  const lines = (payload.lines ?? []).map((l) => ({
    service_id: l.service_id || null,
    name: String(l.name ?? "").trim(),
    price: int(l.price),
    qty: Math.min(Math.max(int(l.qty), 1), 20),
    discount: int(l.discount),
    voucher_id: l.voucher_id || null,
    use_now: !!l.use_now,
  }));
  if (lines.length === 0) fail(appointment_id, "請至少加入一項消費項目");
  if (lines.some((l) => !l.name)) fail(appointment_id, "每一項都要有名稱");

  const { data: services } = await supabase.from("services").select("id, name, price, total_sessions");
  const serviceById = new Map((services ?? []).map((s) => [s.id, s]));

  // 商品券扣堂：確認這張券真的是這位客人的、而且堂數夠
  const voucherUse = new Map<string, number>();
  for (const l of lines) if (l.voucher_id) voucherUse.set(l.voucher_id, (voucherUse.get(l.voucher_id) ?? 0) + 1);
  if (voucherUse.size > 0) {
    if (!customer_id) fail(appointment_id, "商品券扣堂需要選擇會員");
    const { data: vs } = await supabase
      .from("vouchers")
      .select("id, customer_id, remaining_sessions, status")
      .in("id", [...voucherUse.keys()]);
    for (const [id, times] of voucherUse) {
      const v = vs?.find((x) => x.id === id);
      if (!v || v.customer_id !== customer_id || v.status !== "active" || v.remaining_sessions < times) {
        fail(appointment_id, "商品券堂數不足或不屬於這位客人，請重新整理後再試");
      }
    }
  }

  // 每一項算出實收金額；商品券扣堂不收費
  const priced = lines.map((l) => {
    const total = l.voucher_id ? 0 : Math.max(0, l.price * l.qty - l.discount);
    const service = l.service_id ? serviceById.get(l.service_id) : undefined;
    return { ...l, total, isPackage: !!service?.total_sessions && !l.voucher_id, service };
  });
  const payable = priced.reduce((sum, l) => sum + l.total, 0);
  if (cash + transfer !== payable) {
    fail(appointment_id, `現金＋匯款（$${cash + transfer}）要等於應收（$${payable}）`);
  }
  if (priced.some((l) => l.isPackage) && !customer_id) {
    fail(appointment_id, "購買商品券方案需要選擇會員");
  }

  // 一般服務才有材料配方；商品券方案、商品券扣堂、自訂項目都不算（扣堂時才扣材料，見 vouchers/actions.ts 的 useSession）
  const regularLines = priced.filter((l) => l.service_id && l.service && !l.service.total_sessions && !l.voucher_id);
  const { data: recipeRows } =
    regularLines.length > 0
      ? await supabase
          .from("service_products")
          .select("service_id, product_id, quantity")
          .in("service_id", [...new Set(regularLines.map((l) => l.service_id as string))])
      : { data: [] };
  const productIds = [...new Set((recipeRows ?? []).map((r) => r.product_id))];
  const { data: productRows } =
    productIds.length > 0
      ? await supabase.from("products").select("id, cost_price, stock_quantity").in("id", productIds)
      : { data: [] };
  const productMap = new Map((productRows ?? []).map((p) => [p.id, p]));

  const consumedByProduct = new Map<string, number>();
  const unitCostOf = (serviceId: string | null, isRegular: boolean) => {
    if (!serviceId || !isRegular) return 0;
    let cost = 0;
    for (const r of (recipeRows ?? []).filter((x) => x.service_id === serviceId)) {
      cost += r.quantity * (productMap.get(r.product_id)?.cost_price ?? 0);
    }
    return cost;
  };

  // 訂單明細存「折扣後的單價」；金額除不盡時拆成一筆一筆，餘數分給前面幾筆，總額才會對
  const itemRows: {
    service_id: string | null;
    service_name: string;
    price: number;
    quantity: number;
    unit_cost: number;
  }[] = [];
  for (const l of priced) {
    const isRegular = !!l.service_id && !!l.service && !l.service.total_sessions && !l.voucher_id;
    const unitCost = unitCostOf(l.service_id, isRegular);
    if (isRegular) {
      for (const r of (recipeRows ?? []).filter((x) => x.service_id === l.service_id)) {
        consumedByProduct.set(r.product_id, (consumedByProduct.get(r.product_id) ?? 0) + r.quantity * l.qty);
      }
    }
    if (l.total % l.qty === 0) {
      itemRows.push({ service_id: l.service_id, service_name: l.name, price: l.total / l.qty, quantity: l.qty, unit_cost: unitCost });
    } else {
      const base = Math.floor(l.total / l.qty);
      const extra = l.total - base * l.qty;
      for (let i = 0; i < l.qty; i++) {
        itemRows.push({ service_id: l.service_id, service_name: l.name, price: base + (i < extra ? 1 : 0), quantity: 1, unit_cost: unitCost });
      }
    }
  }

  const payment_method = payable === 0 ? null : cash >= transfer ? "cash" : "transfer";
  const { data: order, error } = await supabase
    .from("orders")
    .insert({ appointment_id, customer_id, customer_name, staff_id, total: payable, status: "paid", payment_method })
    .select("id")
    .single();
  if (error || !order) throw new Error("建立訂單失敗");

  await supabase.from("order_items").insert(itemRows.map((i) => ({ ...i, order_id: order.id })));

  for (const [productId, consumedQty] of consumedByProduct) {
    const product = productMap.get(productId);
    if (product) {
      await supabase
        .from("products")
        .update({ stock_quantity: Math.max(0, Math.round(product.stock_quantity - consumedQty)) })
        .eq("id", productId);
    }
  }

  // 購買商品券方案時，自動建立商品券
  const packageLines = priced.filter((l) => l.isPackage && l.service);
  if (packageLines.length > 0 && customer_id) {
    const today = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date());
    // 記下每一行第一張新券的代碼，「今天先用一堂」要扣的就是它
    const firstCodeByLine = new Map<(typeof packageLines)[number], string>();
    const newVouchers = packageLines.flatMap((l) =>
      Array.from({ length: l.qty }, (_, idx) => {
        const code = Math.random().toString(36).slice(2, 10).toUpperCase();
        if (idx === 0) firstCodeByLine.set(l, code);
        return {
        code,
        customer_id,
        service_name: l.service!.name,
        initial_value: l.service!.price,
        remaining_value: l.service!.price,
        total_sessions: l.service!.total_sessions,
        remaining_sessions: l.service!.total_sessions,
        status: "active",
        purchased_at: today,
        issued_at: `${today}T12:00:00+08:00`,
        };
      })
    );
    const { data: created, error: voucherError } = await supabase
      .from("vouchers")
      .insert(newVouchers)
      .select("id, code");
    if (voucherError) throw new Error("建立商品券失敗：" + voucherError.message);

    // 買了馬上用一堂：扣新券 1 堂，並在訂單裡留一筆「今日使用一堂」（不收費）
    for (const l of packageLines) {
      if (!l.use_now) continue;
      const code = firstCodeByLine.get(l);
      const voucher = created?.find((v) => v.code === code);
      if (!voucher) continue;
      await deductVoucherSession(voucher.id);
      await supabase.from("order_items").insert({
        order_id: order.id,
        service_id: l.service_id,
        service_name: `${l.name}（今日使用一堂）`,
        price: 0,
        quantity: 1,
        unit_cost: 0,
      });
    }
  }

  for (const l of priced) {
    if (l.voucher_id) await deductVoucherSession(l.voucher_id);
  }

  // 這次的配方／服務紀錄存進客人資料（失敗不影響開單）
  const recordText = (payload.record ?? "").trim();
  if (recordText && customer_id) {
    const today = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date());
    const { error: recordError } = await supabase
      .from("customer_records")
      .insert({ customer_id, content: recordText, visit_date: today, order_id: order.id });
    if (recordError) console.error("save customer record failed", recordError);
    revalidatePath(`/members/${customer_id}`);
  }

  if (appointment_id) {
    await supabase.from("appointments").update({ status: "completed" }).eq("id", appointment_id);
  }

  revalidatePath("/orders");
  revalidatePath("/appointments");
  revalidatePath("/appointments/calendar");
  revalidatePath("/purchases");
  revalidatePath("/vouchers");
  revalidatePath("/revenue");
  revalidatePath("/members");
  redirect("/orders?success=1");
}

export async function markOrderPaid(id: string, payment_method: "cash" | "transfer") {
  const supabase = await createClient();
  await supabase
    .from("orders")
    .update({ status: "paid", payment_method })
    .eq("id", id);
  revalidatePath("/orders");
  revalidatePath("/revenue");
  revalidatePath("/members");
}
