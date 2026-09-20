"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { findAvailableStaff, getServicesDuration } from "../../book/actions";

export async function createStaffAppointment(formData: FormData) {
  const supabase = await createClient();

  const service_ids = formData.getAll("service_id") as string[];
  const date = formData.get("date") as string;
  const time = formData.get("time") as string;
  const requestedStaffId = (formData.get("staff_id") as string) || null;
  const existingCustomerId = (formData.get("customer_id") as string) || "";
  const newName = ((formData.get("new_customer_name") as string) || "").trim();
  const newPhone = ((formData.get("new_customer_phone") as string) || "").trim();

  const query = `service_id=${service_ids.join(",")}&date=${date}&staff_id=${requestedStaffId ?? ""}`;

  if (service_ids.length === 0 || !date || !time) {
    redirect(`/appointments/new?${query}&error=no_slot`);
  }

  let customer_id = existingCustomerId;
  if (!customer_id) {
    if (!newName || !newPhone) {
      redirect(`/appointments/new?${query}&error=no_customer`);
    }
    const { data: existingId } = await supabase.rpc("find_customer_id_by_phone", {
      p_phone: newPhone,
    });
    if (existingId) {
      customer_id = existingId;
    } else {
      // 建完直接 select 回來需要 customers 的讀取權限，員工登入雖然有但這裡改用跟
      // verifyPhone 一樣的作法（純新增 + RPC 查 id），兩種身份都能用，也比較一致
      const { error: createError } = await supabase
        .from("customers")
        .insert({ name: newName, phone: newPhone });
      if (createError) throw new Error("建立客戶失敗：" + createError.message);

      const { data: newId } = await supabase.rpc("find_customer_id_by_phone", {
        p_phone: newPhone,
      });
      if (!newId) throw new Error("建立客戶失敗");
      customer_id = newId;
    }
  }

  const start_time = `${date}T${time}:00+08:00`;
  const startMs = new Date(start_time).getTime();
  const { duration, maxBuffer } = await getServicesDuration(service_ids);
  const durationMs = (duration + maxBuffer) * 60_000;

  const { ok, staffId } = await findAvailableStaff(date, startMs, startMs + durationMs, requestedStaffId);
  if (!ok) {
    redirect(`/appointments/new?${query}&error=conflict`);
  }

  const { data: appointment, error } = await supabase
    .from("appointments")
    .insert({
      customer_id,
      service_id: service_ids[0],
      start_time,
      status: "confirmed",
      staff_id: staffId,
      buffer_minutes: maxBuffer,
    })
    .select("id")
    .single();

  if (error || !appointment) {
    redirect(`/appointments/new?${query}&error=conflict`);
  }

  if (service_ids.length > 1) {
    await supabase
      .from("appointment_services")
      .insert(service_ids.map((service_id) => ({ appointment_id: appointment.id, service_id })));
  }

  revalidatePath("/appointments");
  revalidatePath("/appointments/calendar");
  revalidatePath("/dashboard");
  redirect("/appointments?success=1");
}
