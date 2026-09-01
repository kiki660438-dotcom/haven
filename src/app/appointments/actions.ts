"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { pushLineMessage } from "@/lib/line";

export async function updateAppointmentStatus(id: string, status: string) {
  const supabase = await createClient();
  await supabase.from("appointments").update({ status }).eq("id", id);
  revalidatePath("/appointments");
  revalidatePath("/dashboard");

  if (status === "confirmed") {
    const { data: appointment } = await supabase
      .from("appointments")
      .select("start_time, customers(line_user_id), services(name), appointment_services(services(name))")
      .eq("id", id)
      .single();

    const customer = Array.isArray(appointment?.customers)
      ? appointment.customers[0]
      : appointment?.customers;
    const linked = (appointment?.appointment_services ?? [])
      .map((row) => (Array.isArray(row.services) ? row.services[0] : row.services))
      .filter((s): s is { name: string } => !!s);
    const single = Array.isArray(appointment?.services) ? appointment.services[0] : appointment?.services;
    const serviceNames = linked.length > 0 ? linked.map((s) => s.name) : single ? [single.name] : [];

    if (customer?.line_user_id && appointment) {
      const time = new Date(appointment.start_time).toLocaleString("zh-TW", {
        timeZone: "Asia/Taipei",
      });
      await pushLineMessage(
        customer.line_user_id,
        `您的預約已確認 ✅\n服務項目：${serviceNames.join("、")}\n時間：${time}\n期待您的光臨！`
      );
    }
  }
}

export async function updateAppointmentTime(id: string, formData: FormData) {
  const supabase = await createClient();
  const date = formData.get("date") as string;
  const time = formData.get("time") as string;
  const bufferHours = Number(formData.get("buffer_hours")) || 0;
  const bufferMinutesPart = Number(formData.get("buffer_minutes")) || 0;
  const buffer_minutes = bufferHours * 60 + bufferMinutesPart;
  if (!date || !time) return;

  const start_time = `${date}T${time}:00+08:00`;
  await supabase.from("appointments").update({ start_time, buffer_minutes }).eq("id", id);
  revalidatePath("/appointments");
  revalidatePath("/dashboard");
}
