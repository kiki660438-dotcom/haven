"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

export async function updateMaxAdvanceBookingDays(formData: FormData) {
  const supabase = await createClient();
  const days = Number(formData.get("booking_max_advance_days"));
  if (!days || days < 1) throw new Error("請輸入大於 0 的天數");

  const { error } = await supabase
    .from("app_settings")
    .upsert({ key: "booking_max_advance_days", value: String(days) });

  if (error) throw new Error("儲存失敗：" + error.message);

  revalidatePath("/settings");
  revalidatePath("/book");
  redirect("/settings?success=1");
}
