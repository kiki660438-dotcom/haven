"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export async function addClosedDate(formData: FormData) {
  const supabase = await createClient();
  const date = formData.get("date") as string;
  const note = (formData.get("note") as string) || null;
  if (!date) return;

  const { error } = await supabase.from("closed_dates").insert({ date, note });
  if (error) {
    console.error("addClosedDate failed", error);
    throw new Error(error.message.includes("duplicate") ? "這天已經設定過公休了" : "新增失敗：" + error.message);
  }

  revalidatePath("/closed-dates");
  revalidatePath("/book");
}

export async function deleteClosedDate(id: string) {
  const supabase = await createClient();
  await supabase.from("closed_dates").delete().eq("id", id);
  revalidatePath("/closed-dates");
  revalidatePath("/book");
}
