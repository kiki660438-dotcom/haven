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
type ServiceDuration = { duration_minutes: number; buffer_minutes: number | null };

// 選多項服務時，用時間最長的那一項來抓時長（不是把每項時間加總）
function combinedDurationBuffer(services: ServiceDuration[]) {
  const duration = services.reduce((max, s) => Math.max(max, s.duration_minutes ?? 60), 0);
  const maxBuffer = services.reduce((max, s) => Math.max(max, s.buffer_minutes ?? 0), 0);
  return { duration, maxBuffer };
}

export async function getServicesDuration(serviceIds: string[]) {
  const { data } = await supabase
    .from("services")
    .select("duration_minutes, buffer_minutes")
    .in("id", serviceIds);
  return combinedDurationBuffer(data ?? []);
}

// 某個時段一旦被預約走，實際佔用的時間＝服務時長＋緩衝時間，這段期間內都不能再被約
async function getBusyIntervals(
  date: string,
  staffId?: string | null,
  excludeAppointmentId?: string
): Promise<BusyInterval[]> {
  const dayStart = `${date}T00:00:00+08:00`;
  const dayEnd = `${date}T23:59:59+08:00`;

  let query = supabase
    .from("appointments")
    .select(
      "id, start_time, status, staff_id, buffer_minutes, services(duration_minutes, buffer_minutes), appointment_services(services(duration_minutes, buffer_minutes))"
    )
    .neq("status", "cancelled")
    .gte("start_time", dayStart)
    .lte("start_time", dayEnd);

  if (staffId) {
    query = query.eq("staff_id", staffId);
  }

  const { data: appointments } = await query;

  return (appointments ?? [])
    .filter((a) => a.id !== excludeAppointmentId)
    .map((a) => {
      const linked = (a.appointment_services ?? [])
        .map((row) => (Array.isArray(row.services) ? row.services[0] : row.services))
        .filter((s): s is ServiceDuration => !!s);

      let duration: number;
      let serviceBuffer: number;
      if (linked.length > 0) {
        const combo = combinedDurationBuffer(linked);
        duration = combo.duration;
        serviceBuffer = combo.maxBuffer;
      } else {
        const service = Array.isArray(a.services) ? a.services[0] : a.services;
        duration = service?.duration_minutes ?? 60;
        serviceBuffer = service?.buffer_minutes ?? 0;
      }

      const start = new Date(a.start_time).getTime();
      // 每筆預約可以自己覆寫緩衝時間（在「預約管理」設定），沒設過就用服務項目的預設值
      const buffer = a.buffer_minutes ?? serviceBuffer;
      return { start, end: start + (duration + buffer) * 60_000 };
    });
}

function overlaps(startA: number, endA: number, busy: BusyInterval[]) {
  return busy.some((b) => startA < b.end && endA > b.start);
}

async function getActiveStaffIds(): Promise<string[]> {
  const { data } = await supabase.from("staff").select("id").eq("active", true);
  return data?.map((s) => s.id) ?? [];
}

// 找出在指定時段有空的員工：客人有指定設計師就只看那個人；沒指定就從所有在職員工裡找一個有空的（找不到就退回「全店共用行事曆」判斷，適用還沒建立員工資料的情況）
export async function findAvailableStaff(
  date: string,
  startMs: number,
  endMs: number,
  requestedStaffId?: string | null,
  excludeAppointmentId?: string
): Promise<{ ok: boolean; staffId: string | null }> {
  if (requestedStaffId) {
    const busy = await getBusyIntervals(date, requestedStaffId, excludeAppointmentId);
    return { ok: !overlaps(startMs, endMs, busy), staffId: requestedStaffId };
  }

  const activeStaffIds = await getActiveStaffIds();
  if (activeStaffIds.length === 0) {
    const busy = await getBusyIntervals(date, null, excludeAppointmentId);
    return { ok: !overlaps(startMs, endMs, busy), staffId: null };
  }

  for (const staffId of activeStaffIds) {
    const busy = await getBusyIntervals(date, staffId, excludeAppointmentId);
    if (!overlaps(startMs, endMs, busy)) {
      return { ok: true, staffId };
    }
  }
  return { ok: false, staffId: null };
}

export async function getAvailableSlots(serviceIds: string[], date: string, staffId?: string) {
  if (serviceIds.length === 0) return [];

  const { duration, maxBuffer } = await getServicesDuration(serviceIds);
  if (duration === 0) return [];

  const durationMs = (duration + maxBuffer) * 60_000;

  let busyLists: BusyInterval[][];
  if (staffId) {
    busyLists = [await getBusyIntervals(date, staffId)];
  } else {
    const activeStaffIds = await getActiveStaffIds();
    if (activeStaffIds.length > 0) {
      busyLists = await Promise.all(activeStaffIds.map((id) => getBusyIntervals(date, id)));
    } else {
      busyLists = [await getBusyIntervals(date, null)];
    }
  }

  const dayOpen = new Date(`${date}T${String(OPEN_HOUR).padStart(2, "0")}:00:00+08:00`).getTime();
  const dayClose = new Date(`${date}T${String(CLOSE_HOUR).padStart(2, "0")}:00:00+08:00`).getTime();

  const slots: string[] = [];
  for (
    let slotStart = dayOpen;
    slotStart + durationMs <= dayClose;
    slotStart += SLOT_STEP_MINUTES * 60_000
  ) {
    const slotEnd = slotStart + durationMs;
    const freeSomewhere = busyLists.some((busy) => !overlaps(slotStart, slotEnd, busy));
    if (freeSomewhere) {
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
  const returnTo = (formData.get("return_to") as string) || `/book?service_id=${service_id}&date=${date}`;

  if (!name || !phone) {
    redirect(`${returnTo}${returnTo.includes("?") ? "&" : "?"}error=no_identity`);
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

  redirect(returnTo);
}

export async function logoutCustomer(formData: FormData) {
  const service_id = (formData.get("service_id") as string) || "";
  const date = (formData.get("date") as string) || "";
  const returnTo = (formData.get("return_to") as string) || `/book?service_id=${service_id}&date=${date}`;
  const cookieStore = await cookies();
  cookieStore.delete(CUSTOMER_COOKIE);
  redirect(returnTo);
}

export async function createBooking(formData: FormData) {
  const customer_id = formData.get("customer_id") as string;
  const service_ids = formData.getAll("service_id") as string[];
  const date = formData.get("date") as string;
  const time = formData.get("time") as string;
  const requestedStaffId = (formData.get("staff_id") as string) || null;
  const query = `service_id=${service_ids.join(",")}&date=${date}`;

  if (!customer_id) {
    redirect(`/book?${query}&error=no_identity`);
  }

  if (service_ids.length === 0) {
    redirect(`/book?${query}&error=no_slot`);
  }

  if (!time) {
    redirect(`/book?${query}&error=no_slot`);
  }

  const start_time = `${date}T${time}:00+08:00`;
  const startMs = new Date(start_time).getTime();

  const { duration, maxBuffer } = await getServicesDuration(service_ids);
  const durationMs = (duration + maxBuffer) * 60_000;

  const { ok, staffId } = await findAvailableStaff(date, startMs, startMs + durationMs, requestedStaffId);
  if (!ok) {
    redirect(`/book?${query}&error=conflict`);
  }

  const { data: appointment, error } = await supabase
    .from("appointments")
    .insert({
      customer_id,
      service_id: service_ids[0],
      start_time,
      status: "pending",
      staff_id: staffId,
      buffer_minutes: maxBuffer,
    })
    .select("id")
    .single();

  if (error || !appointment) {
    redirect(`/book?${query}&error=conflict`);
  }

  if (service_ids.length > 1) {
    await supabase
      .from("appointment_services")
      .insert(service_ids.map((service_id) => ({ appointment_id: appointment.id, service_id })));
  }

  revalidatePath("/book");
  revalidatePath("/appointments");
  redirect("/book?success=1");
}
