"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export async function addCustomer(formData: FormData) {
  const supabase = await createClient();
  const name = formData.get("name") as string;
  const phone = formData.get("phone") as string;
  const email = formData.get("email") as string;
  const note = formData.get("note") as string;
  const birthday = (formData.get("birthday") as string) || null;
  const gender = (formData.get("gender") as string) || null;

  await supabase.from("customers").insert({ name, phone, email, note, birthday, gender });
  revalidatePath("/customers");
}

export async function updateCustomerDemographics(id: string, formData: FormData) {
  const supabase = await createClient();
  const birthday = (formData.get("birthday") as string) || null;
  const gender = (formData.get("gender") as string) || null;

  await supabase.from("customers").update({ birthday, gender }).eq("id", id);
  revalidatePath("/customers");
  revalidatePath("/members");
}

export async function deleteCustomer(id: string) {
  const supabase = await createClient();
  await supabase.from("customers").delete().eq("id", id);
  revalidatePath("/customers");
}
