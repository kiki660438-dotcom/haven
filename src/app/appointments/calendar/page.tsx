import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { ChevronLeft, ChevronRight, List } from "lucide-react";

const statusDot: Record<string, string> = {
  pending: "bg-yellow-400",
  confirmed: "bg-primary-dark",
  cancelled: "bg-red-300",
  completed: "bg-gray-300",
};

const statusChip: Record<string, string> = {
  pending: "bg-yellow-100 text-yellow-800",
  confirmed: "bg-primary-light text-primary-dark",
  completed: "bg-gray-100 text-gray-500",
};

const WEEKDAYS = ["日", "一", "二", "三", "四", "五", "六"];
const MAX_CHIPS_PER_DAY = 3;

function taipeiToday() {
  const parts = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" })
    .format(new Date())
    .split("-")
    .map(Number);
  return { year: parts[0], month: parts[1], day: parts[2] };
}

function pad(n: number) {
  return String(n).padStart(2, "0");
}

// 純粹的日曆日期運算（年/月/日數字），不用 Date 物件的時區換算，避免跨時區誤差
function addDays(year: number, month: number, day: number, delta: number) {
  const d = new Date(Date.UTC(year, month - 1, day + delta));
  return { year: d.getUTCFullYear(), month: d.getUTCMonth() + 1, day: d.getUTCDate() };
}

function daysInMonth(year: number, month: number) {
  return new Date(Date.UTC(year, month, 0)).getUTCDate();
}

function weekdayOf(year: number, month: number, day: number) {
  return new Date(Date.UTC(year, month - 1, day)).getUTCDay();
}

function dateKey(year: number, month: number, day: number) {
  return `${year}-${pad(month)}-${pad(day)}`;
}

type ApptRow = {
  id: string;
  start_time: string;
  status: string;
  customers: { name: string } | { name: string }[] | null;
  staff: { name: string } | { name: string }[] | null;
};

export default async function AppointmentsCalendarPage({
  searchParams,
}: {
  searchParams: Promise<{ month?: string }>;
}) {
  const { month: monthParam } = await searchParams;
  const today = taipeiToday();

  let year = today.year;
  let month = today.month;
  if (monthParam && /^\d{4}-\d{2}$/.test(monthParam)) {
    const [y, m] = monthParam.split("-").map(Number);
    year = y;
    month = m;
  }

  const firstWeekday = weekdayOf(year, month, 1);
  const totalDaysInMonth = daysInMonth(year, month);
  const totalCells = Math.ceil((firstWeekday + totalDaysInMonth) / 7) * 7;
  const gridStart = addDays(year, month, 1, -firstWeekday);

  const cells = Array.from({ length: totalCells }, (_, i) =>
    addDays(gridStart.year, gridStart.month, gridStart.day, i)
  );
  const gridEnd = cells[cells.length - 1];

  const gridStartKey = dateKey(gridStart.year, gridStart.month, gridStart.day);
  const gridEndKey = dateKey(gridEnd.year, gridEnd.month, gridEnd.day);

  const supabase = await createClient();
  const [{ data: appointments }, { data: leaves }] = await Promise.all([
    supabase
      .from("appointments")
      .select("id, start_time, status, customers(name), staff(name)")
      .gte("start_time", `${gridStartKey}T00:00:00+08:00`)
      .lte("start_time", `${gridEndKey}T23:59:59+08:00`)
      .order("start_time", { ascending: true }),
    supabase
      .from("staff_leave")
      .select("start_date, end_date, all_day, start_time, end_time")
      .lte("start_date", gridEndKey)
      .gte("end_date", gridStartKey),
  ]);

  const byDay = new Map<string, ApptRow[]>();
  for (const a of ((appointments ?? []) as ApptRow[]).filter((x) => x.status !== "cancelled")) {
    const key = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(
      new Date(a.start_time)
    );
    if (!byDay.has(key)) byDay.set(key, []);
    byDay.get(key)!.push(a);
  }

  const prevMonth = addDays(year, month, 1, -1);
  const nextMonth = addDays(year, month, totalDaysInMonth, 1);
  const monthLabel = `${year}年${month}月`;
  const todayKey = dateKey(today.year, today.month, today.day);

  return (
    <main className="max-w-5xl mx-auto px-1 py-4 sm:p-8">
      <div className="flex items-center justify-between mb-4 flex-wrap gap-3 px-3 sm:px-0">
        <h1 className="text-2xl font-bold text-primary-dark">預約月曆</h1>
        <Link
          href="/appointments"
          className="inline-flex items-center gap-1.5 text-sm px-3 py-1.5 rounded-full border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
        >
          <List size={14} /> 列表檢視
        </Link>
      </div>

      <div className="flex items-center justify-between mb-4 px-1 sm:px-0">
        <Link
          href={`/appointments/calendar?month=${prevMonth.year}-${pad(prevMonth.month)}`}
          className="p-2 rounded-full hover:bg-primary-light text-primary-dark"
        >
          <ChevronLeft size={18} />
        </Link>
        <div className="flex items-center gap-3">
          <span className="font-semibold text-lg">{monthLabel}</span>
          <Link
            href={`/appointments/calendar?month=${today.year}-${pad(today.month)}`}
            className="text-xs px-2.5 py-1 rounded-full bg-primary-light text-primary-dark"
          >
            今天
          </Link>
        </div>
        <Link
          href={`/appointments/calendar?month=${nextMonth.year}-${pad(nextMonth.month)}`}
          className="p-2 rounded-full hover:bg-primary-light text-primary-dark"
        >
          <ChevronRight size={18} />
        </Link>
      </div>

      <div className="grid grid-cols-7 gap-px sm:gap-1 text-center text-xs text-foreground/50 mb-1">
        {WEEKDAYS.map((w) => (
          <div key={w} className="py-1">
            {w}
          </div>
        ))}
      </div>

      <div className="grid grid-cols-7 gap-px sm:gap-1 bg-primary-light/70 sm:bg-transparent border-y border-primary-light/70 sm:border-0">
        {cells.map((c) => {
          const key = dateKey(c.year, c.month, c.day);
          const inMonth = c.month === month;
          const isToday = key === todayKey;
          const dayAppointments = byDay.get(key) ?? [];
          const shown = dayAppointments.slice(0, MAX_CHIPS_PER_DAY);
          const extra = dayAppointments.length - shown.length;
          const dayLeaves = (leaves ?? []).filter((l) => key >= l.start_date && key <= l.end_date);

          return (
            <Link
              key={key}
              href={`/appointments/day?date=${key}`}
              className={`min-h-24 sm:min-h-28 p-0.5 sm:p-1.5 sm:rounded-lg sm:border text-left flex flex-col gap-0.5 sm:gap-1 transition-colors ${
                inMonth
                  ? `${isToday ? "bg-primary-light/50" : "bg-white"} sm:border-primary-light hover:bg-primary-light/40`
                  : "bg-gray-50 sm:border-gray-100 text-foreground/30 hover:bg-gray-100"
              }`}
            >
              <span
                className={`text-xs w-5 h-5 flex items-center justify-center rounded-full ${
                  isToday ? "bg-primary-dark text-white font-semibold" : ""
                }`}
              >
                {c.day}
              </span>
              {dayLeaves.map((l, i) => (
                <span
                  key={`leave-${i}`}
                  className="block rounded px-0.5 text-[11px] leading-[14px] bg-sky-100 text-sky-700 sm:truncate"
                >
                  排休
                  {!l.all_day && l.start_time && l.end_time
                    ? ` ${l.start_time.slice(0, 5)}-${l.end_time.slice(0, 5)}`
                    : ""}
                </span>
              ))}
              {/* 手機版：格子貼滿畫面、姓名完整顯示（依狀態上色）；桌機顯示時間＋姓名 */}
              <div className="flex sm:hidden flex-col gap-0.5">
                {dayAppointments.map((a) => {
                  const customer = Array.isArray(a.customers) ? a.customers[0] : a.customers;
                  return (
                    <span
                      key={a.id}
                      className={`block break-all rounded px-0.5 text-[11px] leading-[14px] ${
                        statusChip[a.status] ?? "bg-gray-100 text-gray-600"
                      }`}
                    >
                      {customer?.name}
                    </span>
                  );
                })}
              </div>
              <div className="hidden sm:flex flex-col gap-0.5">
                {shown.map((a) => {
                  const customer = Array.isArray(a.customers) ? a.customers[0] : a.customers;
                  const staff = Array.isArray(a.staff) ? a.staff[0] : a.staff;
                  const time = new Date(a.start_time).toLocaleTimeString("zh-TW", {
                    timeZone: "Asia/Taipei",
                    hour: "2-digit",
                    minute: "2-digit",
                  });
                  return (
                    <span
                      key={a.id}
                      className="flex items-center gap-1 text-[11px] leading-tight truncate"
                      title={`${time} ${customer?.name ?? ""}${staff?.name ? `（${staff.name}）` : ""}`}
                    >
                      <span
                        className={`shrink-0 w-1.5 h-1.5 rounded-full ${statusDot[a.status] ?? "bg-gray-300"}`}
                      />
                      <span className="truncate">
                        {time} {customer?.name}
                      </span>
                    </span>
                  );
                })}
                {extra > 0 && <span className="text-[11px] text-foreground/40">+{extra} 筆</span>}
              </div>
            </Link>
          );
        })}
      </div>

      <div className="flex items-center gap-4 mt-4 text-xs text-foreground/50 flex-wrap">
        <span className="flex items-center gap-1">
          <span className="w-1.5 h-1.5 rounded-full bg-yellow-400" /> 待確認
        </span>
        <span className="flex items-center gap-1">
          <span className="w-1.5 h-1.5 rounded-full bg-primary-dark" /> 已確認
        </span>
        <span className="flex items-center gap-1">
          <span className="w-1.5 h-1.5 rounded-full bg-red-300" /> 已取消
        </span>
        <span className="flex items-center gap-1">
          <span className="w-1.5 h-1.5 rounded-full bg-gray-300" /> 已完成
        </span>
      </div>
    </main>
  );
}
