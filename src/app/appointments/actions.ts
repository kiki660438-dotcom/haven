"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { after } from "next/server";
import { pushLineMessage } from "@/lib/line";

function formatDateTime(iso: string) {
  const parts = new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Taipei",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    hour12: false,
  }).formatToParts(new Date(iso));
  const get = (t: string) => parts.find((p) => p.type === t)?.value ?? "";
  return `${get("year")}/${get("month")}/${get("day")} ${get("hour")}:${get("minute")}`;
}

export async function updateAppointmentStatus(id: string, status: string) {
  const supabase = await createClient();

  // 取消前先記下原本的狀態：只有「原本還有效」的預約被取消才通知客人，避免重複點擊重複通知
  const { data: before } =
    status === "cancelled"
      ? await supabase.from("appointments").select("status").eq("id", id).maybeSingle()
      : { data: null };

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
      const dateTime = formatDateTime(appointment.start_time);
      const staffName = staff?.name ?? "KIKI";
      const mapsUrl = "https://maps.app.goo.gl/rkyQPMQHHDYaGvRr5";

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

  if (status === "cancelled" && before && (before.status === "pending" || before.status === "confirmed")) {
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
      const text = `親愛的 ${customer.name ?? ""} 客人您好，您 ${formatDateTime(appointment.start_time)} 設計師${staff?.name ?? "Kiki"}該時段已有其他客人，暫時無法接受您的預約，再請您改約其他時間，謝謝！`;
      after(() => pushLineMessage(customer.line_user_id, text));
    }
  }
}

// 客人自己要求取消、由店家在後台代為取消：只把狀態改成已取消（時段會自動開放給別人預約），
// 不傳任何訊息給客人，因為取消是客人自己提出的
export async function cancelAppointmentQuietly(id: string) {
  const supabase = await createClient();
  await supabase
    .from("appointments")
    .update({ status: "cancelled" })
    .eq("id", id)
    .in("status", ["pending", "confirmed"]);
  revalidatePath("/appointments");
  revalidatePath("/appointments/calendar");
  revalidatePath("/dashboard");
  revalidatePath("/book");
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

export type UpdateDetailsState = { ok: boolean; error?: string } | null;

// 月曆小視窗裡的「編輯預約」：一次改時間、服務項目、緩衝時間、備註。
// 後台自己改，不檢查時段衝突（跟後台代客預約一樣，店長自己評估），也不傳訊息給客人
export async function updateAppointmentDetails(
  id: string,
  _prev: UpdateDetailsState,
  formData: FormData
): Promise<UpdateDetailsState> {
  const supabase = await createClient();
  const date = formData.get("date") as string;
  const time = formData.get("time") as string;
  const serviceIds = [...new Set(formData.getAll("service_id") as string[])];
  const note = ((formData.get("note") as string) || "").trim() || null;
  const buffer_minutes =
    (Math.max(0, Number(formData.get("buffer_hours")) || 0)) * 60 +
    Math.min(59, Math.max(0, Number(formData.get("buffer_minutes")) || 0));

  if (!date || !time) return { ok: false, error: "請填寫日期與時間" };
  if (serviceIds.length === 0) return { ok: false, error: "請至少選擇一項服務" };

  const { error } = await supabase
    .from("appointments")
    .update({
      start_time: `${date}T${time}:00+08:00`,
      buffer_minutes,
      service_id: serviceIds[0],
      note,
    })
    .eq("id", id);
  if (error) {
    console.error("updateAppointmentDetails failed", error);
    return { ok: false, error: `更新失敗：${error.message}` };
  }

  // 多項服務存在 appointment_services，單一項目只用 service_id，沿用既有的存法
  await supabase.from("appointment_services").delete().eq("appointment_id", id);
  if (serviceIds.length > 1) {
    const { error: linkError } = await supabase
      .from("appointment_services")
      .insert(serviceIds.map((service_id) => ({ appointment_id: id, service_id })));
    if (linkError) return { ok: false, error: `服務項目更新失敗：${linkError.message}` };
  }

  revalidatePath("/appointments");
  revalidatePath("/appointments/calendar");
  revalidatePath("/dashboard");
  revalidatePath("/book");
  return { ok: true };
}
