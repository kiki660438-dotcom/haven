"use server";

import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { getAdminClient } from "@/lib/supabase-admin";
import { normalizePhone } from "@/lib/phone";
import {
  CUSTOMER_COOKIE,
  CUSTOMER_COOKIE_MAX_AGE,
  LINE_PENDING_COOKIE,
  signCustomerToken,
  verifyLinePending,
} from "@/lib/customer-identity";

// 只允許站內路徑，避免被拿來導到外部網站
function safeReturnTo(path: string | undefined) {
  return path && path.startsWith("/") && !path.startsWith("//") ? path : "/book";
}

async function finishLogin(customerId: string, name: string, returnTo: string): Promise<never> {
  const cookieStore = await cookies();
  cookieStore.set(CUSTOMER_COOKIE, signCustomerToken(customerId, name), {
    httpOnly: true,
    secure: true,
    sameSite: "lax",
    maxAge: CUSTOMER_COOKIE_MAX_AGE,
    path: "/",
  });
  cookieStore.delete(LINE_PENDING_COOKIE);
  redirect(safeReturnTo(returnTo));
}

async function readPending() {
  const cookieStore = await cookies();
  return verifyLinePending(cookieStore.get(LINE_PENDING_COOKIE)?.value);
}

// 輸入電話：找得到原本的客人就把 LINE 綁上去（以後用 LINE 登入就是同一筆），找不到就用這支電話建新客人
export async function linkLineByPhone(formData: FormData) {
  const pending = await readPending();
  if (!pending) redirect("/line-link?error=expired");

  const phone = normalizePhone(String(formData.get("phone") ?? ""));
  if (!phone) redirect("/line-link?error=phone");

  const { data: existingId } = await supabase.rpc("find_customer_id_by_phone", { p_phone: phone });

  if (existingId) {
    const admin = getAdminClient();
    if (admin) {
      // 這支電話已經綁了別的 LINE 帳號：不要蓋掉，請客人聯絡店家
      const { data: row } = await admin
        .from("customers")
        .select("line_user_id")
        .eq("id", existingId)
        .maybeSingle();
      if (row?.line_user_id && row.line_user_id !== pending.userId) redirect("/line-link?error=bound");
      const { error } = await admin
        .from("customers")
        .update({ line_user_id: pending.userId })
        .eq("id", existingId);
      if (error) redirect("/line-link?error=failed");
    } else {
      const { error } = await supabase.rpc("link_line_user_by_phone", {
        p_phone: phone,
        p_line_user_id: pending.userId,
      });
      if (error) redirect("/line-link?error=failed");
    }

    const { data: rows } = await supabase.rpc("get_customer_name_phone", { p_customer_id: existingId });
    const name = rows?.[0]?.name ?? pending.displayName;
    await finishLogin(existingId, name, pending.returnTo);
  }

  // 新客人：用 LINE 名稱＋這支電話建立，同時綁好 LINE
  const { error } = await supabase
    .from("customers")
    .insert({ name: pending.displayName, phone, line_user_id: pending.userId });
  if (error) redirect("/line-link?error=failed");
  const { data: newId } = await supabase.rpc("find_customer_id_by_phone", { p_phone: phone });
  if (!newId) redirect("/line-link?error=failed");
  await finishLogin(newId, pending.displayName, pending.returnTo);
}

// 沒有台灣手機的客人：照原本的方式，只用 LINE 建立客人資料
export async function skipLineLink() {
  const pending = await readPending();
  if (!pending) redirect("/line-link?error=expired");

  const { data: alreadyId } = await supabase.rpc("find_customer_id_by_line_user_id", {
    p_line_user_id: pending.userId,
  });
  if (alreadyId) await finishLogin(alreadyId, pending.displayName, pending.returnTo);

  const { error } = await supabase
    .from("customers")
    .insert({ name: pending.displayName, line_user_id: pending.userId });
  if (error) redirect("/line-link?error=failed");
  const { data: newId } = await supabase.rpc("find_customer_id_by_line_user_id", {
    p_line_user_id: pending.userId,
  });
  if (!newId) redirect("/line-link?error=failed");
  await finishLogin(newId, pending.displayName, pending.returnTo);
}
