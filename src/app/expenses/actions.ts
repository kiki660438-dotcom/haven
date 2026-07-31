"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export async function addExpense(formData: FormData) {
  const supabase = await createClient();
  const category = formData.get("category") as string;
  const amount = Number(formData.get("amount"));
  const expense_date = formData.get("expense_date") as string;
  const note = (formData.get("note") as string) || null;

  await supabase.from("fixed_expenses").insert({ category, amount, expense_date, note });
  revalidatePath("/expenses");
}

export async function deleteExpense(id: string) {
  const supabase = await createClient();
  await supabase.from("fixed_expenses").delete().eq("id", id);
  revalidatePath("/expenses");
}
