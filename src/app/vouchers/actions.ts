"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export async function useSession(id: string) {
  const supabase = await createClient();

  const { data: voucher } = await supabase
    .from("vouchers")
    .select("remaining_sessions, remaining_value, initial_value, total_sessions, service_name")
    .eq("id", id)
    .single();

  if (!voucher || !voucher.remaining_sessions || voucher.remaining_sessions <= 0) {
    throw new Error("已經沒有剩餘堂數");
  }

  const remaining_sessions = voucher.remaining_sessions - 1;
  const perSession = voucher.total_sessions
    ? voucher.initial_value / voucher.total_sessions
    : 0;
  const remaining_value = Math.max(0, Math.round(voucher.remaining_value - perSession));

  await supabase
    .from("vouchers")
    .update({
      remaining_sessions,
      remaining_value,
      status: remaining_sessions === 0 ? "used" : "active",
    })
    .eq("id", id);

  // 扣這一堂實際用掉的材料庫存：配方是「整個方案」的用量，這裡只扣 1/總堂數
  if (voucher.total_sessions) {
    const { data: service } = await supabase
      .from("services")
      .select("id")
      .eq("name", voucher.service_name)
      .maybeSingle();

    if (service) {
      const { data: recipe } = await supabase
        .from("service_products")
        .select("product_id, quantity")
        .eq("service_id", service.id);

      for (const r of recipe ?? []) {
        const { data: product } = await supabase
          .from("products")
          .select("stock_quantity")
          .eq("id", r.product_id)
          .single();
        if (product) {
          const perSessionQty = r.quantity / voucher.total_sessions;
          await supabase
            .from("products")
            .update({ stock_quantity: Math.max(0, Math.round(product.stock_quantity - perSessionQty)) })
            .eq("id", r.product_id);
        }
      }
      revalidatePath("/purchases");
    }
  }

  revalidatePath("/vouchers");
  revalidatePath("/checkout");
}
