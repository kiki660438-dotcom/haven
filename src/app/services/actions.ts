"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export async function addService(formData: FormData) {
  const supabase = await createClient();
  const name = formData.get("name") as string;
  const price = Number(formData.get("price"));
  const duration_minutes = Number(formData.get("duration_minutes")) || 60;

  await supabase.from("services").insert({ name, price, duration_minutes });
  revalidatePath("/services");
}

export async function deleteService(id: string) {
  const supabase = await createClient();
  await supabase.from("services").delete().eq("id", id);
  revalidatePath("/services");
}

export async function updateService(id: string, formData: FormData) {
  const supabase = await createClient();
  const price = Number(formData.get("price"));
  const duration_minutes = Number(formData.get("duration_minutes"));
  const hide_from_booking = formData.get("hide_from_booking") === "on";

  await supabase
    .from("services")
    .update({ price, duration_minutes, hide_from_booking })
    .eq("id", id);
  revalidatePath("/services");
  revalidatePath("/book");
}

export async function updateServiceRecipe(serviceId: string, formData: FormData) {
  const supabase = await createClient();
  const productIds = formData.getAll("product_id") as string[];
  const quantities = formData.getAll("quantity") as string[];

  const rows = productIds
    .map((product_id, i) => ({
      service_id: serviceId,
      product_id,
      quantity: Number(quantities[i]),
    }))
    .filter((r) => r.product_id && r.quantity > 0);

  await supabase.from("service_products").delete().eq("service_id", serviceId);
  if (rows.length > 0) {
    await supabase.from("service_products").insert(rows);
  }
  revalidatePath("/services");
}
