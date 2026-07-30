"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export async function recordPurchase(formData: FormData) {
  const supabase = await createClient();
  const productName = (formData.get("product_name") as string).trim();
  const quantity = Number(formData.get("quantity"));
  const unit_cost = Number(formData.get("unit_cost"));
  const supplier = (formData.get("supplier") as string) || null;
  const unit = (formData.get("unit") as string) || "個";
  const total_cost = quantity * unit_cost;

  const { data: existing } = await supabase
    .from("products")
    .select("id, stock_quantity")
    .eq("name", productName)
    .maybeSingle();

  let productId: string;

  if (existing) {
    productId = existing.id;
    await supabase
      .from("products")
      .update({
        stock_quantity: existing.stock_quantity + quantity,
        cost_price: unit_cost,
      })
      .eq("id", productId);
  } else {
    const { data: created, error } = await supabase
      .from("products")
      .insert({ name: productName, unit, stock_quantity: quantity, cost_price: unit_cost })
      .select("id")
      .single();
    if (error || !created) throw new Error("建立商品失敗");
    productId = created.id;
  }

  await supabase.from("purchase_records").insert({
    product_id: productId,
    quantity,
    unit_cost,
    total_cost,
    supplier,
  });

  revalidatePath("/purchases");
}
