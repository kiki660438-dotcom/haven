"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { getActiveStaffIds } from "../../book/actions";

export async function createStaffAppointment(formData: FormData) {
  const supabase = await createClient();

  const service_ids = formData.getAll("service_id") as string[];
  const date = formData.get("date") as string;
  const time = formData.get("time") as string;
  const requestedStaffId = (formData.get("staff_id") as string) || null;
  const existingCustomerId = (formData.get("customer_id") as string) || "";
  const newName = ((formData.get("new_customer_name") as string) || "").trim();
  const newPhone = ((formData.get("new_customer_phone") as string) || "").trim();
  const note = ((formData.get("note") as string) || "").trim() || null;
  const bufferHours = Number(formData.get("buffer_hours")) || 0;
  const bufferMinutesPart = Number(formData.get("buffer_minutes")) || 0;
  const buffer_minutes = bufferHours * 60 + bufferMinutesPart;

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

  // 後台代客預約是員工自己手動排的，就算時段跟別的預約重疊也讓她排——她通常是評估過覺得
  // 可以同時服務（例如客人在等染劑上色時排進下一位客人），跟線上預約需要自動擋線不一樣
  let staffId = requestedStaffId;
  if (!staffId) {
    const activeStaffIds = await getActiveStaffIds();
    staffId = activeStaffIds[0] ?? null;
  }

  const { data: appointment, error } = await supabase
    .from("appointments")
    .insert({
      customer_id,
      service_id: service_ids[0],
      start_time,
      status: "confirmed",
      staff_id: staffId,
      buffer_minutes,
      note,
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
