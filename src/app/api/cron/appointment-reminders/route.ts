import { NextResponse } from "next/server";
import { supabase } from "@/lib/supabase";
import { pushLineMessage } from "@/lib/line";

export async function GET(request: Request) {
  const authHeader = request.headers.get("authorization");
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: "unauthorized" }, { status: 401 });
  }

  const tomorrow = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(
    new Date(Date.now() + 24 * 60 * 60 * 1000)
  );
  const dayStart = `${tomorrow}T00:00:00+08:00`;
  const dayEnd = `${tomorrow}T23:59:59+08:00`;

  const { data: appointments, error } = await supabase.rpc("get_appointments_needing_reminder", {
    p_start: dayStart,
    p_end: dayEnd,
  });

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  let sent = 0;
  for (const a of appointments ?? []) {
    const time = new Date(a.start_time).toLocaleString("zh-TW", {
      timeZone: "Asia/Taipei",
      hour: "2-digit",
      minute: "2-digit",
    });

    await pushLineMessage(a.line_user_id, `提醒您，明天 ${time} 有預約「${a.service_name}」，期待您的光臨！`);
    await supabase.rpc("mark_reminder_sent", { p_appointment_id: a.appointment_id });
    sent++;
  }

  return NextResponse.json({ ok: true, sent });
}
