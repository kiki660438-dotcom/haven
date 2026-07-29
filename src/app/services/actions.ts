"use server";

import { supabase } from "@/lib/supabase";
import { revalidatePath } from "next/cache";

export async function addService(formData: FormData) {
  const name = formData.get("name") as string;
  const price = Number(formData.get("price"));
  const duration_minutes = Number(formData.get("duration_minutes")) || 60;

  await supabase.from("services").insert({ name, price, duration_minutes });
  revalidatePath("/services");
}

export async function deleteService(id: string) {
  await supabase.from("services").delete().eq("id", id);
  revalidatePath("/services");
}
