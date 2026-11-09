"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { getActiveStaffIds } from "../../book/actions";

// 不要用 throw：正式環境會把錯誤訊息藏起來，只顯示「This page couldn't load」，
// 改成帶著原因導回表單，畫面上才看得到到底是哪裡出錯
function failWith(query: string, message: string): never {
  redirect(`/appointments/new?${query}&error=failed&message=${encodeURIComponent(message)}`);
}

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

  // 服務可以複選，要用重複的 service_id 參數帶回去（不能用逗號串起來，頁面讀不懂）
  const params = new URLSearchParams();
  for (const id of service_ids) params.append("service_id", id);
  params.set("date", date ?? "");
  params.set("staff_id", requestedStaffId ?? "");
  params.set("customer_id", existingCustomerId);
  const query = params.toString();

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
      if (createError) {
        console.error("createStaffAppointment: insert customer failed", createError);
        failWith(query, "建立新客人失敗：" + createError.message);
      }

      const { data: newId, error: lookupError } = await supabase.rpc("find_customer_id_by_phone", {
        p_phone: newPhone,
      });
      if (!newId) {
        console.error("createStaffAppointment: lookup new customer failed", lookupError);
        failWith(query, "新客人已建立，但找不到他的資料" + (lookupError ? "：" + lookupError.message : ""));
      }
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
    console.error("createStaffAppointment: insert appointment failed", error);
    failWith(query, "建立預約失敗" + (error ? "：" + error.message : ""));
  }

  if (service_ids.length > 1) {
    const { error: servicesError } = await supabase
      .from("appointment_services")
      .insert(service_ids.map((service_id) => ({ appointment_id: appointment.id, service_id })));
    if (servicesError) console.error("createStaffAppointment: insert services failed", servicesError);
  }

  revalidatePath("/appointments");
  revalidatePath("/appointments/calendar");
  revalidatePath("/dashboard");
  redirect("/appointments?success=1");
}
