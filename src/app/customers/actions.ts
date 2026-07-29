"use server";

import { supabase } from "@/lib/supabase";
import { revalidatePath } from "next/cache";

export async function addCustomer(formData: FormData) {
  const name = formData.get("name") as string;
  const phone = formData.get("phone") as string;
  const email = formData.get("email") as string;
  const note = formData.get("note") as string;

  await supabase.from("customers").insert({ name, phone, email, note });
  revalidatePath("/customers");
}

export async function deleteCustomer(id: string) {
  await supabase.from("customers").delete().eq("id", id);
  revalidatePath("/customers");
}
