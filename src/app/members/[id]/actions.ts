"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export type RecordState = { ok: boolean; error?: string } | null;

function refresh(customerId: string) {
  revalidatePath(`/members/${customerId}`);
  revalidatePath("/appointments/day");
}

export async function addCustomerRecord(
  customerId: string,
  _prev: RecordState,
  formData: FormData
): Promise<RecordState> {
  const content = String(formData.get("content") ?? "").trim();
  const visitDate = String(formData.get("visit_date") ?? "");
  if (!content) return { ok: false, error: "請先寫下內容" };
  if (!/^\d{4}-\d{2}-\d{2}$/.test(visitDate)) return { ok: false, error: "日期格式不正確" };

  const supabase = await createClient();
  const { error } = await supabase
    .from("customer_records")
    .insert({ customer_id: customerId, visit_date: visitDate, content });
  if (error) return { ok: false, error: `儲存失敗：${error.message}` };
  refresh(customerId);
  return { ok: true };
}

export async function updateCustomerRecord(
  id: string,
  customerId: string,
  _prev: RecordState,
  formData: FormData
): Promise<RecordState> {
  const content = String(formData.get("content") ?? "").trim();
  const visitDate = String(formData.get("visit_date") ?? "");
  if (!content) return { ok: false, error: "內容不能空白" };
  if (!/^\d{4}-\d{2}-\d{2}$/.test(visitDate)) return { ok: false, error: "日期格式不正確" };

  const supabase = await createClient();
  const { error } = await supabase
    .from("customer_records")
    .update({ content, visit_date: visitDate })
    .eq("id", id);
  if (error) return { ok: false, error: `儲存失敗：${error.message}` };
  refresh(customerId);
  return { ok: true };
}

export async function deleteCustomerRecord(id: string, customerId: string) {
  const supabase = await createClient();
  await supabase.from("customer_records").delete().eq("id", id);
  refresh(customerId);
}
