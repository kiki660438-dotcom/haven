"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export async function useSession(id: string) {
  const supabase = await createClient();

  const { data: voucher } = await supabase
    .from("vouchers")
    .select("remaining_sessions, remaining_value, initial_value, total_sessions")
    .eq("id", id)
    .single();

  if (!voucher || !voucher.remaining_sessions || voucher.remaining_sessions <= 0) {
    throw new Error("已經沒有剩餘堂數");
  }

  const remaining_sessions = voucher.remaining_sessions - 1;
  const perSession = voucher.total_sessions
    ? voucher.initial_value / voucher.total_sessions
    : 0;
  const remaining_value = Math.max(0, Math.round(voucher.remaining_value - perSession));

  await supabase
    .from("vouchers")
    .update({
      remaining_sessions,
      remaining_value,
      status: remaining_sessions === 0 ? "used" : "active",
    })
    .eq("id", id);

  revalidatePath("/vouchers");
  revalidatePath("/checkout");
}
