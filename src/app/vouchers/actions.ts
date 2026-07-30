"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

function randomCode() {
  return Math.random().toString(36).slice(2, 10).toUpperCase();
}

export async function issueVoucher(formData: FormData) {
  const supabase = await createClient();
  const customer_id = (formData.get("customer_id") as string) || null;
  const initial_value = Number(formData.get("initial_value"));
  const expires_at = (formData.get("expires_at") as string) || null;

  await supabase.from("vouchers").insert({
    code: randomCode(),
    customer_id,
    initial_value,
    remaining_value: initial_value,
    expires_at,
  });

  revalidatePath("/vouchers");
}

export async function redeemVoucher(id: string, formData: FormData) {
  const supabase = await createClient();
  const amount = Number(formData.get("amount"));

  const { data: voucher } = await supabase
    .from("vouchers")
    .select("remaining_value")
    .eq("id", id)
    .single();

  if (!voucher || amount <= 0 || amount > voucher.remaining_value) {
    throw new Error("使用金額不合法");
  }

  const remaining = voucher.remaining_value - amount;

  await supabase
    .from("vouchers")
    .update({
      remaining_value: remaining,
      status: remaining === 0 ? "used" : "active",
    })
    .eq("id", id);

  revalidatePath("/vouchers");
}
