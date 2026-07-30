"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

export async function createOrder(formData: FormData) {
  const supabase = await createClient();
  const appointment_id = (formData.get("appointment_id") as string) || null;
  const customer_id = (formData.get("customer_id") as string) || null;
  const customer_name = (formData.get("customer_name") as string) || null;

  const { data: services } = await supabase.from("services").select("*");

  const items =
    services
      ?.map((s) => {
        const qty = Number(formData.get(`qty_${s.id}`)) || 0;
        return qty > 0
          ? { service_id: s.id, service_name: s.name, price: s.price, quantity: qty }
          : null;
      })
      .filter((i): i is NonNullable<typeof i> => i !== null) ?? [];

  if (items.length === 0) {
    throw new Error("請至少選擇一項服務");
  }

  const total = items.reduce((sum, i) => sum + i.price * i.quantity, 0);

  const { data: order, error } = await supabase
    .from("orders")
    .insert({ appointment_id, customer_id, customer_name, total })
    .select("id")
    .single();

  if (error || !order) throw new Error("建立訂單失敗");

  await supabase
    .from("order_items")
    .insert(items.map((i) => ({ ...i, order_id: order.id })));

  if (appointment_id) {
    await supabase
      .from("appointments")
      .update({ status: "completed" })
      .eq("id", appointment_id);
  }

  revalidatePath("/orders");
  revalidatePath("/appointments");
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
