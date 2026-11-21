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

// 有訂單、預約、商品券或配方紀錄的客人不刪（配方紀錄會被一起刪掉、其他的會刪不掉），
// 要整理重複客人請到會員頁用「合併重複的客人」
export async function deleteCustomer(id: string) {
  const supabase = await createClient();
  for (const table of ["orders", "appointments", "vouchers", "customer_records"] as const) {
    const { count, error } = await supabase
      .from(table)
      .select("id", { count: "exact", head: true })
      .eq("customer_id", id);
    if (error || (count ?? 0) > 0) return;
  }
  await supabase.from("customers").delete().eq("id", id);
  revalidatePath("/customers");
}
