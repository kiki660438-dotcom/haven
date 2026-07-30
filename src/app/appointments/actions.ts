"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { pushLineMessage } from "@/lib/line";

export async function updateAppointmentStatus(id: string, status: string) {
  const supabase = await createClient();
  await supabase.from("appointments").update({ status }).eq("id", id);
  revalidatePath("/appointments");

  if (status === "confirmed") {
    const { data: appointment } = await supabase
      .from("appointments")
      .select("start_time, customers(line_user_id), services(name)")
      .eq("id", id)
      .single();

    const customer = Array.isArray(appointment?.customers)
      ? appointment.customers[0]
      : appointment?.customers;
    const service = Array.isArray(appointment?.services)
      ? appointment.services[0]
      : appointment?.services;

    if (customer?.line_user_id && appointment) {
      const time = new Date(appointment.start_time).toLocaleString("zh-TW", {
        timeZone: "Asia/Taipei",
      });
      await pushLineMessage(
        customer.line_user_id,
        `您的預約已確認 ✅\n服務項目：${service?.name}\n時間：${time}\n期待您的光臨！`
      );
    }
  }
}
