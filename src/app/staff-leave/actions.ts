"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";

export async function addStaffLeave(formData: FormData) {
  const supabase = await createClient();
  const wholeStore = formData.get("whole_store") === "on";
  const staff_id = wholeStore ? null : (formData.get("staff_id") as string) || null;
  const start_date = formData.get("start_date") as string;
  const end_date = (formData.get("end_date") as string) || start_date;
  const all_day = formData.get("all_day") === "on";
  const pad = (n: number) => String(n).padStart(2, "0");
  const start_time = all_day
    ? null
    : `${pad(Number(formData.get("start_hour")) || 0)}:${pad(Number(formData.get("start_minute")) || 0)}`;
  const end_time = all_day
    ? null
    : `${pad(Number(formData.get("end_hour")) || 0)}:${pad(Number(formData.get("end_minute")) || 0)}`;
  const note = (formData.get("note") as string) || null;

  if (!start_date) return;
  if (!wholeStore && !staff_id) throw new Error("請選擇設計師，或勾選「全門店」");

  const { error } = await supabase.from("staff_leave").insert({
    staff_id,
    start_date,
    end_date,
    all_day,
    start_time,
    end_time,
    note,
  });
  if (error) {
    console.error("addStaffLeave failed", error);
    throw new Error("新增失敗：" + error.message);
  }

  revalidatePath("/staff-leave");
  revalidatePath("/book");
}

export async function deleteStaffLeave(id: string) {
  const supabase = await createClient();
  await supabase.from("staff_leave").delete().eq("id", id);
  revalidatePath("/staff-leave");
  revalidatePath("/book");
}
