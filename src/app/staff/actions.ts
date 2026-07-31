"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export async function addStaff(formData: FormData) {
  const supabase = await createClient();
  const name = formData.get("name") as string;
  const commission_rate = Number(formData.get("commission_rate")) || 0;

  await supabase.from("staff").insert({ name, commission_rate });
  revalidatePath("/staff");
}

export async function updateStaff(id: string, formData: FormData) {
  const supabase = await createClient();
  const commission_rate = Number(formData.get("commission_rate")) || 0;
  const active = formData.get("active") === "on";

  await supabase.from("staff").update({ commission_rate, active }).eq("id", id);
  revalidatePath("/staff");
  revalidatePath("/checkout");
  revalidatePath("/payroll");
}

export async function deleteStaff(id: string) {
  const supabase = await createClient();
  await supabase.from("staff").delete().eq("id", id);
  revalidatePath("/staff");
}
