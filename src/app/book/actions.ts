"use server";

import { supabase } from "@/lib/supabase";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

export async function createBooking(formData: FormData) {
  const name = formData.get("name") as string;
  const phone = formData.get("phone") as string;
  const service_id = formData.get("service_id") as string;
  // datetime-local 沒有時區資訊，這裡明確當作台灣時間（+08:00）處理
  const start_time = `${formData.get("start_time")}:00+08:00`;

  let customerId: string;

  const { data: existing } = await supabase
    .from("customers")
    .select("id")
    .eq("phone", phone)
    .maybeSingle();

  if (existing) {
    customerId = existing.id;
  } else {
    const { data: created, error } = await supabase
      .from("customers")
      .insert({ name, phone })
      .select("id")
      .single();
    if (error || !created) throw new Error("建立客戶失敗");
    customerId = created.id;
  }

  await supabase.from("appointments").insert({
    customer_id: customerId,
    service_id,
    start_time,
    status: "pending",
  });

  revalidatePath("/book");
  revalidatePath("/appointments");
  redirect("/book?success=1");
}
