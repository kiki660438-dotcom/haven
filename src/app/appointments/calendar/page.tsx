import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { ChevronLeft, ChevronRight, List } from "lucide-react";

const statusDot: Record<string, string> = {
  pending: "bg-yellow-400",
  confirmed: "bg-primary-dark",
  cancelled: "bg-red-300",
  completed: "bg-gray-300",
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

  const supabase = await createClient();
  const { data: appointments } = await supabase
    .from("appointments")
    .select("id, start_time, status, customers(name), staff(name)")
    .gte("start_time", `${dateKey(gridStart.year, gridStart.month, gridStart.day)}T00:00:00+08:00`)
    .lte("start_time", `${dateKey(gridEnd.year, gridEnd.month, gridEnd.day)}T23:59:59+08:00`)
    .order("start_time", { ascending: true });

  const byDay = new Map<string, ApptRow[]>();
  for (const a of (appointments ?? []) as ApptRow[]) {
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
    <main className="max-w-5xl mx-auto p-8">
      <div className="flex items-center justify-between mb-4 flex-wrap gap-3">
        <h1 className="text-2xl font-bold text-primary-dark">預約月曆</h1>
        <Link
          href="/appointments"
          className="inline-flex items-center gap-1.5 text-sm px-3 py-1.5 rounded-full border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
        >
          <List size={14} /> 列表檢視
        </Link>
      </div>

      <div className="flex items-center justify-between mb-4">
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

      <div className="grid grid-cols-7 gap-1 text-center text-xs text-foreground/50 mb-1">
        {WEEKDAYS.map((w) => (
          <div key={w} className="py-1">
            {w}
          </div>
        ))}
      </div>

      <div className="grid grid-cols-7 gap-1">
        {cells.map((c) => {
          const key = dateKey(c.year, c.month, c.day);
          const inMonth = c.month === month;
          const isToday = key === todayKey;
          const dayAppointments = byDay.get(key) ?? [];
          const shown = dayAppointments.slice(0, MAX_CHIPS_PER_DAY);
          const extra = dayAppointments.length - shown.length;

          return (
            <Link
              key={key}
              href={`/appointments?date=${key}`}
              className={`min-h-24 sm:min-h-28 p-1.5 rounded-lg border text-left flex flex-col gap-1 transition-colors ${
                inMonth
                  ? "bg-white border-primary-light hover:bg-primary-light/40"
                  : "bg-gray-50 border-gray-100 text-foreground/30 hover:bg-gray-100"
              }`}
            >
              <span
                className={`text-xs w-5 h-5 flex items-center justify-center rounded-full ${
                  isToday ? "bg-primary-dark text-white font-semibold" : ""
                }`}
              >
                {c.day}
              </span>
              {/* 手機版空間太窄放不下文字，只顯示狀態色點；桌機顯示時間＋姓名 */}
              <div className="flex sm:hidden flex-wrap gap-0.5">
                {shown.map((a) => (
                  <span
                    key={a.id}
                    className={`w-1.5 h-1.5 rounded-full ${statusDot[a.status] ?? "bg-gray-300"}`}
                  />
                ))}
                {extra > 0 && (
                  <span className="text-[10px] text-foreground/40 leading-none">+{extra}</span>
                )}
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
