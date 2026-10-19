import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { updateAppointmentStatus } from "../actions";
import CopyMessageButton from "../CopyMessageButton";
import { getLineDisplayName } from "@/lib/line";
import { Check, ChevronLeft, ChevronRight, ShoppingCart, List } from "lucide-react";

const statusLabel: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  completed: "已完成",
};

const statusStyle: Record<string, string> = {
  pending: "bg-yellow-100 text-yellow-700",
  confirmed: "bg-primary-light text-primary-dark",
  completed: "bg-gray-100 text-gray-500",
};

const WEEKDAYS = ["日", "一", "二", "三", "四", "五", "六"];

function todayKey() {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date());
}

function addDays(key: string, n: number) {
  return new Date(Date.parse(`${key}T00:00:00Z`) + n * 86_400_000).toISOString().slice(0, 10);
}

function weekdayIndex(key: string) {
  return new Date(`${key}T00:00:00Z`).getUTCDay();
}

function dateKeyOf(iso: string) {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date(iso));
}

function timeOf(iso: string) {
  return new Intl.DateTimeFormat("en-GB", {
    timeZone: "Asia/Taipei",
    hour: "2-digit",
    minute: "2-digit",
    hourCycle: "h23",
  }).format(new Date(iso));
}

function durationLabel(minutes: number) {
  const h = Math.floor(minutes / 60);
  const m = minutes % 60;
  return `${h > 0 ? `${h} 小時` : ""}${m > 0 ? ` ${m} 分` : ""}`.trim();
}

type ServiceRow = { name: string; price: number; duration_minutes: number | null };

export default async function DayPage({
  searchParams,
}: {
  searchParams: Promise<{ date?: string }>;
}) {
  const { date: rawDate } = await searchParams;
  const today = todayKey();
  const date = rawDate && /^\d{4}-\d{2}-\d{2}$/.test(rawDate) ? rawDate : today;

  const weekStart = addDays(date, -weekdayIndex(date));
  const weekDays = Array.from({ length: 7 }, (_, i) => addDays(weekStart, i));

  const supabase = await createClient();
  const { data } = await supabase
    .from("appointments")
    .select(
      "id, start_time, status, note, created_at, party_size, customers(name, phone, line_user_id), staff(name), services(name, price, duration_minutes), appointment_services(services(name, price, duration_minutes))"
    )
    .neq("status", "cancelled")
    .gte("start_time", `${weekStart}T00:00:00+08:00`)
    .lt("start_time", `${addDays(weekStart, 7)}T00:00:00+08:00`)
    .order("start_time", { ascending: true })
    .order("created_at", { ascending: true });

  const week = (data ?? []).map((a) => ({ ...a, dateKey: dateKeyOf(a.start_time) }));
  const countByDay = new Map<string, number>();
  for (const a of week) countByDay.set(a.dateKey, (countByDay.get(a.dateKey) ?? 0) + 1);
  const dayList = week.filter((a) => a.dateKey === date);
  const pendingCount = dayList.filter((a) => a.status === "pending").length;

  const heading = new Intl.DateTimeFormat("zh-TW", {
    timeZone: "Asia/Taipei",
    month: "long",
    day: "numeric",
    weekday: "short",
  }).format(new Date(`${date}T00:00:00+08:00`));

  const lineIds = [
    ...new Set(
      dayList
        .map((a) => (Array.isArray(a.customers) ? a.customers[0] : a.customers)?.line_user_id)
        .filter((id): id is string => !!id)
    ),
  ];
  const lineNames = new Map(
    await Promise.all(lineIds.map(async (id) => [id, await getLineDisplayName(id)] as const))
  );

  const byTime = new Map<string, typeof dayList>();
  for (const a of dayList) {
    const t = timeOf(a.start_time);
    if (!byTime.has(t)) byTime.set(t, []);
    byTime.get(t)!.push(a);
  }

  return (
    <main className="max-w-3xl mx-auto p-8">
      <div className="flex items-center justify-between mb-4 gap-3 flex-wrap">
        <div>
          <Link href="/appointments" className="text-sm text-primary-dark inline-flex items-center gap-1">
            <List size={14} /> 預約管理
          </Link>
          <h1 className="text-2xl font-bold text-primary-dark mt-1">
            {date === today ? "今天・" : ""}
            {heading}
          </h1>
        </div>
        <div className="text-right">
          <p className="text-3xl font-bold text-primary-dark leading-none">{dayList.length}</p>
          <p className="text-xs text-foreground/50 mt-1">
            位客人{pendingCount > 0 ? `（${pendingCount} 筆待確認）` : ""}
          </p>
        </div>
      </div>

      <div className="flex items-center gap-1 mb-6">
        <Link
          href={`/appointments/day?date=${addDays(date, -7)}`}
          aria-label="上一週"
          className="p-2 rounded-lg hover:bg-primary-light text-primary-dark"
        >
          <ChevronLeft size={20} />
        </Link>
        <div className="grid grid-cols-7 gap-1 flex-1">
          {weekDays.map((d) => {
            const count = countByDay.get(d) ?? 0;
            const selected = d === date;
            return (
              <Link
                key={d}
                href={`/appointments/day?date=${d}`}
                className={`flex flex-col items-center py-2 rounded-xl transition-colors ${
                  selected ? "bg-primary-dark text-white" : "hover:bg-primary-light text-foreground"
                }`}
              >
                <span className={`text-xs ${selected ? "text-white/80" : "text-foreground/50"}`}>
                  {WEEKDAYS[weekdayIndex(d)]}
                </span>
                <span className={`text-lg font-semibold ${d === today && !selected ? "text-primary-dark" : ""}`}>
                  {Number(d.slice(8))}
                </span>
                <span
                  className={`text-[11px] rounded-full px-1.5 min-w-5 text-center ${
                    count === 0
                      ? "opacity-0"
                      : selected
                        ? "bg-white/25 text-white"
                        : "bg-primary-light text-primary-dark"
                  }`}
                >
                  {count || "0"}
                </span>
              </Link>
            );
          })}
        </div>
        <Link
          href={`/appointments/day?date=${addDays(date, 7)}`}
          aria-label="下一週"
          className="p-2 rounded-lg hover:bg-primary-light text-primary-dark"
        >
          <ChevronRight size={20} />
        </Link>
      </div>

      {date !== today && (
        <Link
          href={`/appointments/day?date=${today}`}
          className="inline-block text-sm text-primary-dark underline mb-4"
        >
          回到今天
        </Link>
      )}

      {dayList.length === 0 && (
        <p className="text-center text-foreground/50 py-12">這天沒有預約</p>
      )}

      <div className="flex flex-col gap-5">
        {[...byTime.entries()].map(([time, list]) => (
          <div key={time}>
            <div className="flex items-center gap-2 mb-2">
              <span className="text-lg font-bold text-primary-dark">{time}</span>
              <span className="text-xs text-foreground/50">{list.length} 組客人</span>
              <div className="flex-1 border-t border-primary-light" />
            </div>
            <div className="flex flex-col gap-3">
              {list.map((a, order) => {
                const customer = Array.isArray(a.customers) ? a.customers[0] : a.customers;
                const staff = Array.isArray(a.staff) ? a.staff[0] : a.staff;
                const linked = (a.appointment_services ?? [])
                  .map((row) => (Array.isArray(row.services) ? row.services[0] : row.services))
                  .filter((s): s is ServiceRow => !!s);
                const single = Array.isArray(a.services) ? a.services[0] : a.services;
                const services = linked.length > 0 ? linked : single ? [single as ServiceRow] : [];
                const duration =
                  services.reduce((max, s) => Math.max(max, s.duration_minutes ?? 60), 0) * (a.party_size ?? 1);

                return (
                  <div key={a.id} className="p-4 border border-primary-light rounded-xl bg-white">
                    <div className="flex items-start justify-between gap-3">
                      <p className="font-semibold">
                        {customer?.name}
                        <span className="font-normal text-xs text-foreground/50 ml-2">{customer?.phone}</span>
                        {customer?.line_user_id ? (
                          <span className="font-normal text-xs px-2 py-0.5 rounded-full bg-green-100 text-green-700 ml-2">
                            LINE：{lineNames.get(customer.line_user_id) ?? "（查不到暱稱）"}
                          </span>
                        ) : (
                          <span className="font-normal text-xs px-2 py-0.5 rounded-full bg-gray-100 text-gray-500 ml-2">
                            未綁定 LINE，請用電話聯絡
                          </span>
                        )}
                        {staff?.name && (
                          <span className="font-normal text-xs text-primary-dark ml-2">指定 {staff.name}</span>
                        )}
                        {(a.party_size ?? 1) > 1 && (
                          <span className="font-normal text-xs px-2 py-0.5 rounded-full bg-orange-100 text-orange-700 ml-2">
                            {a.party_size} 位
                          </span>
                        )}
                      </p>
                      <span className="flex items-center gap-1.5 shrink-0">
                        {list.length > 1 && (
                          <span className="text-xs px-2 py-1 rounded-full bg-orange-100 text-orange-700 whitespace-nowrap">
                            第 {order + 1} 位預約
                          </span>
                        )}
                        <span
                          className={`text-xs px-2 py-1 rounded-full whitespace-nowrap ${
                            statusStyle[a.status] ?? "bg-gray-100 text-gray-500"
                          }`}
                        >
                          {statusLabel[a.status] ?? a.status}
                        </span>
                      </span>
                    </div>
                    <p className="text-sm text-foreground/70 mt-1">
                      {services.map((s) => s.name).join("、")}
                      <span className="text-foreground/40">　約 {durationLabel(duration)}</span>
                    </p>
                    {a.note && <p className="text-xs text-foreground/50 mt-1">備註：{a.note}</p>}
                    <p className="text-[11px] text-foreground/40 mt-1">
                      建立時間 {dateKeyOf(a.created_at)} {timeOf(a.created_at)}
                    </p>

                    <div className="flex flex-wrap items-center gap-2 mt-3">
                      {a.status === "pending" && (
                        <form action={updateAppointmentStatus.bind(null, a.id, "confirmed")}>
                          <button className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg bg-primary-dark text-white hover:bg-primary transition-colors">
                            <Check size={14} /> 確認
                          </button>
                        </form>
                      )}
                      <CopyMessageButton kind="confirm" name={customer?.name ?? ""} startIso={a.start_time} />
                      <CopyMessageButton kind="decline" name={customer?.name ?? ""} startIso={a.start_time} />
                      <Link
                        href={`/checkout?appointment=${a.id}`}
                        className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
                      >
                        <ShoppingCart size={14} /> 開單
                      </Link>
                      <Link
                        href={`/appointments?date=${date}`}
                        className="text-xs text-foreground/50 underline hover:text-primary-dark"
                      >
                        更多操作
                      </Link>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        ))}
      </div>
    </main>
  );
}
