"use server";

import { supabase } from "@/lib/supabase";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { cookies } from "next/headers";
import {
  CUSTOMER_COOKIE,
  CUSTOMER_COOKIE_MAX_AGE,
  signCustomerToken,
} from "@/lib/customer-identity";

const OPEN_HOUR = 11;
const CLOSE_HOUR = 18;
const SLOT_STEP_MINUTES = 30;

type BusyInterval = { start: number; end: number };

async function getBusyIntervals(date: string): Promise<BusyInterval[]> {
  const dayStart = `${date}T00:00:00+08:00`;
  const dayEnd = `${date}T23:59:59+08:00`;

  const { data: appointments } = await supabase
    .from("appointments")
    .select("start_time, status, services(duration_minutes)")
    .neq("status", "cancelled")
    .gte("start_time", dayStart)
    .lte("start_time", dayEnd);

  return (
    appointments?.map((a) => {
      const service = Array.isArray(a.services) ? a.services[0] : a.services;
      const start = new Date(a.start_time).getTime();
      const duration = service?.duration_minutes ?? 60;
      return { start, end: start + duration * 60_000 };
    }) ?? []
  );
}

function overlaps(startA: number, endA: number, busy: BusyInterval[]) {
  return busy.some((b) => startA < b.end && endA > b.start);
}

export async function getAvailableSlots(serviceId: string, date: string) {
  const { data: service } = await supabase
    .from("services")
    .select("duration_minutes")
    .eq("id", serviceId)
    .single();

  if (!service) return [];

  const durationMs = service.duration_minutes * 60_000;
  const busy = await getBusyIntervals(date);

  const dayOpen = new Date(`${date}T${String(OPEN_HOUR).padStart(2, "0")}:00:00+08:00`).getTime();
  const dayClose = new Date(`${date}T${String(CLOSE_HOUR).padStart(2, "0")}:00:00+08:00`).getTime();

  const slots: string[] = [];
  for (
    let slotStart = dayOpen;
    slotStart + durationMs <= dayClose;
    slotStart += SLOT_STEP_MINUTES * 60_000
  ) {
    if (!overlaps(slotStart, slotStart + durationMs, busy)) {
      const d = new Date(slotStart);
      const hh = String((d.getUTCHours() + 8) % 24).padStart(2, "0");
      const mm = String(d.getUTCMinutes()).padStart(2, "0");
      slots.push(`${hh}:${mm}`);
    }
  }

  return slots;
}

export async function verifyPhone(formData: FormData) {
  const name = (formData.get("name") as string)?.trim();
  const phone = (formData.get("phone") as string)?.trim();
  const birthday = (formData.get("birthday") as string) || null;
  const gender = (formData.get("gender") as string) || null;
  const service_id = (formData.get("service_id") as string) || "";
  const date = (formData.get("date") as string) || "";
  const query = `service_id=${service_id}&date=${date}`;

  if (!name || !phone) {
    redirect(`/book?${query}&error=no_identity`);
  }

  const { data: existingId } = await supabase.rpc("find_customer_id_by_phone", {
    p_phone: phone,
  });

  let customerId: string;
  if (existingId) {
    customerId = existingId;
  } else {
    const { error } = await supabase.from("customers").insert({ name, phone, birthday, gender });
    if (error) throw new Error("建立客戶失敗");

    const { data: newId } = await supabase.rpc("find_customer_id_by_phone", {
      p_phone: phone,
    });
    if (!newId) throw new Error("建立客戶失敗");
    customerId = newId;
  }

  const cookieStore = await cookies();
  cookieStore.set(CUSTOMER_COOKIE, signCustomerToken(customerId, name), {
    httpOnly: true,
    secure: true,
    sameSite: "lax",
    maxAge: CUSTOMER_COOKIE_MAX_AGE,
    path: "/",
  });

  redirect(`/book?${query}`);
}

export async function logoutCustomer(formData: FormData) {
  const service_id = (formData.get("service_id") as string) || "";
  const date = (formData.get("date") as string) || "";
  const cookieStore = await cookies();
  cookieStore.delete(CUSTOMER_COOKIE);
  redirect(`/book?service_id=${service_id}&date=${date}`);
}

export async function createBooking(formData: FormData) {
  const customer_id = formData.get("customer_id") as string;
  const service_id = formData.get("service_id") as string;
  const date = formData.get("date") as string;
  const time = formData.get("time") as string;

  if (!customer_id) {
    redirect(`/book?service_id=${service_id}&date=${date}&error=no_identity`);
  }

  if (!time) {
    redirect(`/book?service_id=${service_id}&date=${date}&error=no_slot`);
  }

  const start_time = `${date}T${time}:00+08:00`;

  const { data: service } = await supabase
    .from("services")
    .select("duration_minutes")
    .eq("id", service_id)
    .single();
  const durationMs = (service?.duration_minutes ?? 60) * 60_000;
  const startMs = new Date(start_time).getTime();

  const busy = await getBusyIntervals(date);
  if (overlaps(startMs, startMs + durationMs, busy)) {
    redirect(`/book?service_id=${service_id}&date=${date}&error=conflict`);
  }

  await supabase.from("appointments").insert({
    customer_id,
    service_id,
    start_time,
    status: "pending",
  });

  revalidatePath("/book");
  revalidatePath("/appointments");
  redirect("/book?success=1");
}
