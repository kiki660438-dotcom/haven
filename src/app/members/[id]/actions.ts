"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

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

export type MergeState = { ok: boolean; error?: string } | null;

// 合併重複的客人（例如用 LINE 登入自動建立、沒有電話的那筆，跟神美匯入、有消費紀錄的那筆）。
// 留下有電話的那一筆（兩筆都有或都沒有時，留下目前這頁的客人），把預約、訂單、商品券、配方紀錄、
// LINE 綁定都移過去，再刪掉另一筆。
export async function mergeCustomers(
  currentId: string,
  _prev: MergeState,
  formData: FormData
): Promise<MergeState> {
  const otherId = String(formData.get("other_id") ?? "");
  if (!otherId) return { ok: false, error: "請先選擇要合併的客人" };
  if (otherId === currentId) return { ok: false, error: "不能跟自己合併" };

  const supabase = await createClient();
  const { data: rows, error: loadError } = await supabase
    .from("customers")
    .select("id, name, phone, line_user_id, birthday, gender, email, note")
    .in("id", [currentId, otherId]);
  if (loadError) return { ok: false, error: `讀取客人失敗：${loadError.message}` };
  const current = rows?.find((r) => r.id === currentId);
  const other = rows?.find((r) => r.id === otherId);
  if (!current || !other) return { ok: false, error: "找不到其中一位客人，請重新整理再試" };

  const keep = !current.phone && other.phone ? other : current;
  const drop = keep.id === current.id ? other : current;
  if (keep.line_user_id && drop.line_user_id && keep.line_user_id !== drop.line_user_id) {
    return { ok: false, error: "兩位客人綁定的是不同的 LINE 帳號，看起來不是同一個人，沒有合併" };
  }

  const tables = ["appointments", "orders", "vouchers", "customer_records"] as const;

  // 合併紀錄：記下被刪那筆的完整資料、留下那筆合併前的資料、搬了哪些東西，合併錯了可以用
  // supabase/undo_customer_merge.sql 拆回來。還沒建立紀錄表（沒跑過 merge_line_duplicates.sql）時就略過
  const { data: dropFull } = await supabase.from("customers").select("*").eq("id", drop.id).maybeSingle();
  const { data: keepFull } = await supabase.from("customers").select("*").eq("id", keep.id).maybeSingle();
  const moved: Record<string, string[]> = {};
  for (const table of tables) {
    const { data } = await supabase.from(table).select("id").eq("customer_id", drop.id);
    moved[table] = (data ?? []).map((r) => r.id as string);
  }
  const { error: logError } = await supabase.from("customer_merge_log").insert({
    kept_customer_id: keep.id,
    removed_customer: dropFull,
    kept_before: keepFull,
    moved,
    source: "member_page",
  });
  if (logError) console.warn("customer_merge_log insert skipped", logError.message);

  for (const table of tables) {
    const { error } = await supabase.from(table).update({ customer_id: keep.id }).eq("customer_id", drop.id);
    if (error) return { ok: false, error: `搬移資料失敗（${table}）：${error.message}` };
  }

  // 先清掉要刪的那筆的 LINE，再綁到留下的那筆，避免同一個 LINE 同時綁兩個人
  if (drop.line_user_id) {
    const { error } = await supabase.from("customers").update({ line_user_id: null }).eq("id", drop.id);
    if (error) return { ok: false, error: `搬移 LINE 綁定失敗：${error.message}` };
  }
  const { error: updateError } = await supabase
    .from("customers")
    .update({
      line_user_id: keep.line_user_id ?? drop.line_user_id,
      birthday: keep.birthday ?? drop.birthday,
      gender: keep.gender ?? drop.gender,
      email: keep.email ?? drop.email,
      note: [keep.note, drop.note].filter(Boolean).join("\n") || null,
    })
    .eq("id", keep.id);
  if (updateError) return { ok: false, error: `更新客人資料失敗：${updateError.message}` };

  const { error: deleteError } = await supabase.from("customers").delete().eq("id", drop.id);
  if (deleteError) return { ok: false, error: `資料已搬好，但刪除重複的客人失敗：${deleteError.message}` };

  revalidatePath("/customers");
  revalidatePath("/members");
  revalidatePath("/appointments");
  revalidatePath("/appointments/calendar");
  redirect(`/members/${keep.id}?merged=1`);
}

export type DeleteState = { ok: boolean; error?: string } | null;

// 刪除客人：只允許刪「完全沒有訂單、預約、商品券、配方紀錄」的客人（例如建錯、空白的重複資料）。
// 有資料的要用「合併重複的客人」，資料才不會跟著消失
export async function deleteCustomerSafely(customerId: string): Promise<DeleteState> {
  const supabase = await createClient();
  const counts = await Promise.all(
    (["orders", "appointments", "vouchers", "customer_records"] as const).map(async (table) => {
      const { count, error } = await supabase
        .from(table)
        .select("id", { count: "exact", head: true })
        .eq("customer_id", customerId);
      return { table, count: error ? -1 : count ?? 0 };
    })
  );
  if (counts.some((c) => c.count === -1)) return { ok: false, error: "檢查資料失敗，請重新整理再試" };

  const label: Record<string, string> = {
    orders: "訂單",
    appointments: "預約",
    vouchers: "商品券",
    customer_records: "配方紀錄",
  };
  const has = counts.filter((c) => c.count > 0).map((c) => `${label[c.table]} ${c.count} 筆`);
  if (has.length > 0) {
    return {
      ok: false,
      error: `這位客人還有${has.join("、")}，不能直接刪除（資料會一起消失）。如果是重複的客人，請用上面的「合併重複的客人」。`,
    };
  }

  const { error } = await supabase.from("customers").delete().eq("id", customerId);
  if (error) return { ok: false, error: `刪除失敗：${error.message}` };

  revalidatePath("/customers");
  revalidatePath("/members");
  redirect("/customers");
}
