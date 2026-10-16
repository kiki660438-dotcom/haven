"use server";

import { supabase } from "@/lib/supabase";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { after } from "next/server";
import { cookies } from "next/headers";
import { verifyCustomerToken, CUSTOMER_COOKIE } from "@/lib/customer-identity";
import { notifyOwner } from "@/lib/line";
import { findAvailableStaff, getServicesDuration } from "../book/actions";
import { earliestBookingDate } from "@/lib/booking-window";

function formatTime(iso: string) {
  return new Date(iso).toLocaleString("zh-TW", {
    timeZone: "Asia/Taipei",
    month: "numeric",
    day: "numeric",
    hour: "2-digit",
    minute: "2-digit",
    hour12: false,
  });
}

async function describeAppointment(customerId: string, serviceIds: string[]) {
  const [{ data: customerRows }, { data: services }] = await Promise.all([
    supabase.rpc("get_customer_name_phone", { p_customer_id: customerId }),
    supabase.from("services").select("name").in("id", serviceIds),
  ]);
  const customer = customerRows?.[0];
  return {
    who: `${customer?.name ?? ""}（${customer?.phone ?? ""}）`,
    serviceNames: (services ?? []).map((x) => x.name).join("、"),
  };
}

export async function cancelMyAppointment(appointmentId: string) {
  const cookieStore = await cookies();
  const identity = verifyCustomerToken(cookieStore.get(CUSTOMER_COOKIE)?.value);
  if (!identity) return;

  const { data: before } = await supabase
    .from("appointments")
    .select("customer_id, start_time, status, service_id, appointment_services(service_id)")
    .eq("id", appointmentId)
    .maybeSingle();

  await supabase.rpc("cancel_own_appointment", {
    p_appointment_id: appointmentId,
    p_customer_id: identity.customerId,
  });

  // 只有「原本還有效」的預約被取消才通知，避免客人連點兩次收到重複通知
  if (
    before &&
    before.customer_id === identity.customerId &&
    before.status !== "cancelled" &&
    before.status !== "completed"
  ) {
    const serviceIds = before.appointment_services?.length
      ? before.appointment_services.map((row) => row.service_id)
      : [before.service_id];
    const oldTime = before.start_time;
    after(async () => {
      const { who, serviceNames } = await describeAppointment(identity.customerId, serviceIds);
      await notifyOwner(
        `客人取消預約\n${who}\n原本時間：${formatTime(oldTime)}\n${serviceNames}`
      );
    });
  }

  revalidatePath("/my");
  revalidatePath("/appointments");
  revalidatePath("/appointments/calendar");
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

  if (date < earliestBookingDate()) {
    redirect(`/my?reschedule=${appointmentId}&r_date=${date}&error=no_slot`);
  }

  const { data: appointment } = await supabase
    .from("appointments")
    .select("id, customer_id, staff_id, service_id, start_time, appointment_services(service_id)")
    .eq("id", appointmentId)
    .single();

  if (!appointment || appointment.customer_id !== identity.customerId) {
    redirect("/my");
  }

  const linkedServiceIds = appointment.appointment_services?.length
    ? appointment.appointment_services.map((row) => row.service_id)
    : [appointment.service_id];
  const { duration, maxBuffer } = await getServicesDuration(linkedServiceIds);
  const durationMs = (duration + maxBuffer) * 60_000;
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

  const oldTime = appointment.start_time;
  after(async () => {
    const { who, serviceNames } = await describeAppointment(identity.customerId, linkedServiceIds);
    await notifyOwner(
      `客人改期（待確認）\n${who}\n原本：${formatTime(oldTime)}\n改到：${formatTime(start_time)}\n${serviceNames}\n請到後台確認`
    );
  });

  revalidatePath("/my");
  revalidatePath("/appointments");
  revalidatePath("/appointments/calendar");
  redirect("/my?success=reschedule");
}
