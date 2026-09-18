"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

export async function createOrder(formData: FormData) {
  const supabase = await createClient();
  const appointment_id = (formData.get("appointment_id") as string) || null;
  const customer_id = (formData.get("customer_id") as string) || null;
  const customer_name = (formData.get("customer_name") as string) || null;
  const staff_id = (formData.get("staff_id") as string) || null;

  const { data: services } = await supabase.from("services").select("*");

  const MAX_QTY = 20;

  const items =
    services
      ?.map((s) => {
        const qty = Math.min(Number(formData.get(`qty_${s.id}`)) || 0, MAX_QTY);
        return qty > 0
          ? { service_id: s.id, service_name: s.name, price: s.price, quantity: qty }
          : null;
      })
      .filter((i): i is NonNullable<typeof i> => i !== null) ?? [];

  if (items.length === 0) {
    throw new Error("請至少選擇一項服務");
  }

  const total = items.reduce((sum, i) => sum + i.price * i.quantity, 0);

  // 依每個服務的「配方」算出這筆訂單實際用掉多少材料成本，並在結帳時扣除對應庫存
  const { data: recipeRows } = await supabase
    .from("service_products")
    .select("service_id, product_id, quantity")
    .in(
      "service_id",
      items.map((i) => i.service_id)
    );

  const productIds = [...new Set((recipeRows ?? []).map((r) => r.product_id))];
  const { data: productRows } =
    productIds.length > 0
      ? await supabase.from("products").select("id, cost_price, stock_quantity").in("id", productIds)
      : { data: [] };
  const productMap = new Map((productRows ?? []).map((p) => [p.id, p]));

  const consumedByProduct = new Map<string, number>();
  const itemsWithCost = items.map((item) => {
    const recipe = (recipeRows ?? []).filter((r) => r.service_id === item.service_id);
    let unit_cost = 0;
    for (const r of recipe) {
      const product = productMap.get(r.product_id);
      unit_cost += r.quantity * (product?.cost_price ?? 0);
      consumedByProduct.set(
        r.product_id,
        (consumedByProduct.get(r.product_id) ?? 0) + r.quantity * item.quantity
      );
    }
    return { ...item, unit_cost };
  });

  const { data: order, error } = await supabase
    .from("orders")
    .insert({ appointment_id, customer_id, customer_name, staff_id, total })
    .select("id")
    .single();

  if (error || !order) throw new Error("建立訂單失敗");

  await supabase
    .from("order_items")
    .insert(itemsWithCost.map((i) => ({ ...i, order_id: order.id })));

  for (const [productId, consumedQty] of consumedByProduct) {
    const product = productMap.get(productId);
    if (product) {
      await supabase
        .from("products")
        .update({ stock_quantity: Math.max(0, Math.round(product.stock_quantity - consumedQty)) })
        .eq("id", productId);
    }
  }

  // 購買商品券方案（有堂數的服務項目）時，自動建立商品券
  const packageItems = items.filter((i) =>
    services?.some((s) => s.id === i.service_id && s.total_sessions)
  );
  if (packageItems.length > 0 && customer_id) {
    const today = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date());
    const newVouchers = packageItems.flatMap((i) => {
      const service = services!.find((s) => s.id === i.service_id)!;
      return Array.from({ length: i.quantity }, () => ({
        code: Math.random().toString(36).slice(2, 10).toUpperCase(),
        customer_id,
        service_name: service.name,
        initial_value: service.price,
        remaining_value: service.price,
        total_sessions: service.total_sessions,
        remaining_sessions: service.total_sessions,
        status: "active",
        purchased_at: today,
        issued_at: `${today}T12:00:00+08:00`,
      }));
    });
    const { error: voucherError } = await supabase.from("vouchers").insert(newVouchers);
    if (voucherError) throw new Error("建立商品券失敗：" + voucherError.message);
    revalidatePath("/vouchers");
  }

  if (appointment_id) {
    await supabase
      .from("appointments")
      .update({ status: "completed" })
      .eq("id", appointment_id);
  }

  revalidatePath("/orders");
  revalidatePath("/appointments");
  revalidatePath("/purchases");
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
