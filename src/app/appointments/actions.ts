"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { pushLineMessage } from "@/lib/line";

export async function updateAppointmentStatus(id: string, status: string) {
  const supabase = await createClient();
  await supabase.from("appointments").update({ status }).eq("id", id);
  revalidatePath("/appointments");
  revalidatePath("/appointments/calendar");
  revalidatePath("/dashboard");

  if (status === "confirmed") {
    const { data: appointment } = await supabase
      .from("appointments")
      .select("start_time, customers(line_user_id, name), staff(name)")
      .eq("id", id)
      .single();

    const customer = Array.isArray(appointment?.customers)
      ? appointment.customers[0]
      : appointment?.customers;
    const staff = Array.isArray(appointment?.staff) ? appointment.staff[0] : appointment?.staff;

    if (customer?.line_user_id && appointment) {
      const parts = new Intl.DateTimeFormat("en-CA", {
        timeZone: "Asia/Taipei",
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
        hour: "2-digit",
        minute: "2-digit",
        hour12: false,
      }).formatToParts(new Date(appointment.start_time));
      const get = (t: string) => parts.find((p) => p.type === t)?.value ?? "";
      const dateTime = `${get("year")}/${get("month")}/${get("day")} ${get("hour")}:${get("minute")}`;
      const staffName = staff?.name ?? "KIKI";
      const mapsUrl = `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(
        "新竹市東區北大路92巷40弄1號1樓"
      )}`;

      await pushLineMessage(
        customer.line_user_id,
        `親愛的 ${customer?.name ?? ""} 客人您好，\n設計師 ${staffName} 已經接受您的預約了喔！\n門店：Haven Hair\n預約時間：${dateTime}\n地址：${mapsUrl}\n\n服務人員\n${staffName}`
      );
    }

    // 確認完直接跳到那個月的月曆總覽，方便馬上看到整體排程
    if (appointment) {
      const monthKey = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" })
        .format(new Date(appointment.start_time))
        .slice(0, 7);
      redirect(`/appointments/calendar?month=${monthKey}`);
    }
  }
}

export type UpdateTimeState = { ok: boolean; error?: string } | null;

export async function updateAppointmentTime(
  id: string,
  _prevState: UpdateTimeState,
  formData: FormData
): Promise<UpdateTimeState> {
  const supabase = await createClient();
  const date = formData.get("date") as string;
  const time = formData.get("time") as string;
  const bufferHours = Number(formData.get("buffer_hours")) || 0;
  const bufferMinutesPart = Number(formData.get("buffer_minutes")) || 0;
  const buffer_minutes = bufferHours * 60 + bufferMinutesPart;
  if (!date || !time) return { ok: false, error: "請填寫日期與時間" };

  const start_time = `${date}T${time}:00+08:00`;
  const { error } = await supabase
    .from("appointments")
    .update({ start_time, buffer_minutes })
    .eq("id", id);
  if (error) {
    console.error("updateAppointmentTime failed", error);
    return { ok: false, error: `更新失敗：${error.message}` };
  }
  revalidatePath("/appointments");
  revalidatePath("/appointments/calendar");
  revalidatePath("/dashboard");
  return { ok: true };
}
