"use server";

import { supabase } from "@/lib/supabase";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { cookies } from "next/headers";
import { verifyCustomerToken, CUSTOMER_COOKIE } from "@/lib/customer-identity";
import { findAvailableStaff, getServicesDuration } from "../book/actions";

export async function cancelMyAppointment(appointmentId: string) {
  const cookieStore = await cookies();
  const identity = verifyCustomerToken(cookieStore.get(CUSTOMER_COOKIE)?.value);
  if (!identity) return;

  await supabase.rpc("cancel_own_appointment", {
    p_appointment_id: appointmentId,
    p_customer_id: identity.customerId,
  });

  revalidatePath("/my");
}

export async function rescheduleMyAppointment(appointmentId: string, formData: FormData) {
  const cookieStore = await cookies();
  const identity = verifyCustomerToken(cookieStore.get(CUSTOMER_COOKIE)?.value);
  if (!identity) redirect("/my");

  const date = formData.get("date") as string;
  const time = formData.get("time") as string;

  if (!date || !time) {
    redirect(`/my?reschedule=${appointmentId}&r_date=${date ?? ""}&error=no_slot`);
  }

  const { data: appointment } = await supabase
    .from("appointments")
    .select("id, customer_id, staff_id, service_id, appointment_services(service_id)")
    .eq("id", appointmentId)
    .single();

  if (!appointment || appointment.customer_id !== identity.customerId) {
    redirect("/my");
  }

  const linkedServiceIds = appointment.appointment_services?.length
    ? appointment.appointment_services.map((row) => row.service_id)
    : [appointment.service_id];
  const { totalDuration, maxBuffer } = await getServicesDuration(linkedServiceIds);
  const durationMs = (totalDuration + maxBuffer) * 60_000;
  const start_time = `${date}T${time}:00+08:00`;
  const startMs = new Date(start_time).getTime();

  const { ok } = await findAvailableStaff(
    date,
    startMs,
    startMs + durationMs,
    appointment.staff_id,
    appointmentId
  );

  if (!ok) {
    redirect(`/my?reschedule=${appointmentId}&r_date=${date}&error=conflict`);
  }

  await supabase.rpc("reschedule_own_appointment", {
    p_appointment_id: appointmentId,
    p_customer_id: identity.customerId,
    p_start_time: start_time,
  });

  revalidatePath("/my");
  revalidatePath("/appointments");
  redirect("/my?success=reschedule");
}
