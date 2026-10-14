"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { parseMonthlyOpen } from "@/lib/booking-window";

export async function updateBookingWindow(formData: FormData) {
  const supabase = await createClient();
  const mode = (formData.get("mode") as string) || "monthly";
  const openUntil = ((formData.get("booking_open_until") as string) || "").trim();
  const day = Number(formData.get("monthly_day"));
  const hour = Number(formData.get("monthly_hour"));
  const days = Number(formData.get("booking_max_advance_days"));

  let monthly = "";
  if (mode === "monthly") {
    monthly = `${day}:${hour}`;
    if (!parseMonthlyOpen(monthly)) throw new Error("每月開放的日期要是 1~28 號、時間 0~23 點");
  }
  if (mode === "fixed" && !/^\d{4}-\d{2}-\d{2}$/.test(openUntil)) throw new Error("請選擇開放到哪一天");
  if (mode === "rolling" && (!days || days < 1)) throw new Error("請輸入大於 0 的天數");

  // 三種方式一次只啟用一種：沒被選到的就清空，系統才不會混用
  const rows = [
    { key: "booking_monthly_open", value: mode === "monthly" ? monthly : "" },
    { key: "booking_open_until", value: mode === "fixed" ? openUntil : "" },
    ...(days >= 1 ? [{ key: "booking_max_advance_days", value: String(days) }] : []),
  ];
  const { error } = await supabase.from("app_settings").upsert(rows);
  if (error) throw new Error("儲存失敗：" + error.message);

  revalidatePath("/settings");
  revalidatePath("/book");
  redirect("/settings?success=1");
}
