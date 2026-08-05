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
