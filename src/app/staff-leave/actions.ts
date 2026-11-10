"use server";

import { createClient } from "@/lib/supabase-server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

// 不要用 throw：正式環境會把錯誤訊息藏起來，只顯示「This page couldn't load」，
// 改成帶著原因導回頁面，畫面上才看得到要修正什麼
function failWith(message: string): never {
  redirect(`/staff-leave?error=${encodeURIComponent(message)}`);
}

export async function addStaffLeave(formData: FormData) {
  const supabase = await createClient();
  const wholeStore = formData.get("whole_store") === "on";
  const staff_id = wholeStore ? null : (formData.get("staff_id") as string) || null;
  const start_date = formData.get("start_date") as string;
  const end_date = (formData.get("end_date") as string) || start_date;
  const all_day = formData.get("all_day") === "on";
  const start_time = all_day ? null : (formData.get("start_time") as string) || null;
  const end_time = all_day ? null : (formData.get("end_time") as string) || null;
  const note = (formData.get("note") as string) || null;

  if (!start_date) failWith("請選擇開始日期");
  if (!wholeStore && !staff_id) failWith("請選擇設計師，或勾選「全門店」");
  if (end_date < start_date) failWith("結束日期不能早於開始日期");
  if (!all_day && (!start_time || !end_time || end_time <= start_time)) {
    failWith("不是整天的話，結束時間要晚於開始時間");
  }

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
    failWith("新增失敗：" + error.message);
  }

  revalidatePath("/staff-leave");
  revalidatePath("/book");
  redirect("/staff-leave?success=1");
}

export async function deleteStaffLeave(id: string) {
  const supabase = await createClient();
  const { error } = await supabase.from("staff_leave").delete().eq("id", id);
  if (error) {
    console.error("deleteStaffLeave failed", error);
    failWith("取消失敗：" + error.message);
  }
  revalidatePath("/staff-leave");
  revalidatePath("/book");
}
