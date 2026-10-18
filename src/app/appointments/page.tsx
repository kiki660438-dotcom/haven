import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { updateAppointmentStatus, cancelAppointmentQuietly } from "./actions";
import UpdateTimeForm from "./UpdateTimeForm";
import { Check, X, ShoppingCart, ChevronDown, Calendar, CalendarSearch, Plus } from "lucide-react";

const statusLabel: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  cancelled: "已取消",
  completed: "已完成",
};

const statusStyle: Record<string, string> = {
  pending: "bg-yellow-100 text-yellow-700",
  confirmed: "bg-primary-light text-primary-dark",
  cancelled: "bg-red-50 text-red-500",
  completed: "bg-gray-100 text-gray-500",
};

function toDateInputValue(iso: string) {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date(iso));
}

function toTimeInputValue(iso: string) {
  // 用 hourCycle: "h23" 明確指定 00:00-23:59，避免 hour12:false 在部分環境把午夜格式化成
  // "24:00" 這種 <input type="time"> 不接受的無效值，導致該欄位悄悄變空、送出時整筆更新被擋下
  return new Intl.DateTimeFormat("en-GB", {
    timeZone: "Asia/Taipei",
    hour: "2-digit",
    minute: "2-digit",
    hourCycle: "h23",
  }).format(new Date(iso));
}

function todayKey() {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date());
}

function dateHeading(key: string) {
  const d = new Date(`${key}T00:00:00+08:00`);
  const weekday = new Intl.DateTimeFormat("zh-TW", { timeZone: "Asia/Taipei", weekday: "short" }).format(d);
  const md = new Intl.DateTimeFormat("zh-TW", {
    timeZone: "Asia/Taipei",
    month: "long",
    day: "numeric",
  }).format(d);
  return `${key === todayKey() ? "今天・" : ""}${md}（${weekday}）`;
}

type ServiceRow = {
  name: string;
  price: number;
  total_sessions: number | null;
  buffer_minutes: number | null;
};

export default async function AppointmentsPage({
  searchParams,
}: {
  searchParams: Promise<{ filter?: string; date?: string; success?: string }>;
}) {
  const { filter, date, success } = await searchParams;
  const activeFilter = date ? "date" : filter ?? "upcoming";

  const supabase = await createClient();
  const { data: appointments } = await supabase
    .from("appointments")
    .select(
      "id, start_time, created_at, status, buffer_minutes, party_size, note, customers(name, phone), staff(name), services(name, price, total_sessions, buffer_minutes), appointment_services(services(name, price, total_sessions, buffer_minutes))"
    )
    .order("start_time", { ascending: true })
    .order("created_at", { ascending: true });

  const today = todayKey();
  const pendingCount = appointments?.filter((a) => a.status === "pending").length ?? 0;

  const withKey = (appointments ?? []).map((a) => ({
    ...a,
    dateKey: new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date(a.start_time)),
  }));

  const filtered = withKey.filter((a) => {
    // 已取消的預約只在「已取消」分頁看得到，其他畫面一律不顯示，避免版面雜亂
    if (activeFilter === "cancelled") return a.status === "cancelled";
    if (a.status === "cancelled") return false;
    if (activeFilter === "date") return a.dateKey === date;
    if (activeFilter === "pending") return a.status === "pending";
    if (activeFilter === "today") return a.dateKey === today;
    if (activeFilter === "all") return true;
    return a.dateKey >= today;
  });

  const groups = new Map<string, typeof filtered>();
  for (const a of filtered) {
    if (!groups.has(a.dateKey)) groups.set(a.dateKey, []);
    groups.get(a.dateKey)!.push(a);
  }
  const sortedKeys = [...groups.keys()].sort();

  const tabs = [
    { key: "upcoming", label: "即將到來" },
    { key: "pending", label: pendingCount > 0 ? `待確認 (${pendingCount})` : "待確認" },
    { key: "today", label: "今天" },
    { key: "all", label: "全部" },
    { key: "cancelled", label: "已取消" },
  ];

  return (
    <main className="max-w-3xl mx-auto p-8">
      <div className="flex items-center justify-between mb-4 flex-wrap gap-3">
        <h1 className="text-2xl font-bold text-primary-dark">預約管理</h1>
        <div className="flex gap-2">
          <Link
            href="/appointments/new"
            className="inline-flex items-center gap-1.5 text-sm px-3 py-1.5 rounded-full bg-primary-dark text-white hover:bg-primary transition-colors"
          >
            <Plus size={14} /> 新增預約
          </Link>
          <Link
            href="/appointments/day"
            className="inline-flex items-center gap-1.5 text-sm px-3 py-1.5 rounded-full border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
          >
            <CalendarSearch size={14} /> 今日預約
          </Link>
          <Link
            href="/appointments/calendar"
            className="inline-flex items-center gap-1.5 text-sm px-3 py-1.5 rounded-full border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
          >
            <Calendar size={14} /> 月曆檢視
          </Link>
        </div>
      </div>

      {success && (
        <div className="mb-4 p-4 rounded-xl bg-primary-light text-primary-dark">
          預約建立成功！
        </div>
      )}

      <div className="flex gap-2 mb-6 flex-wrap items-center">
        {tabs.map((t) => (
          <Link
            key={t.key}
            href={`/appointments?filter=${t.key}`}
            className={`px-3 py-1.5 rounded-full text-sm whitespace-nowrap transition-colors ${
              activeFilter === t.key
                ? "bg-primary-dark text-white"
                : "bg-primary-light text-primary-dark hover:bg-primary/30"
            }`}
          >
            {t.label}
          </Link>
        ))}
        {activeFilter === "date" && date && (
          <span className="px-3 py-1.5 rounded-full text-sm bg-foreground/10 text-foreground/70 whitespace-nowrap">
            {date}
          </span>
        )}
      </div>

      {sortedKeys.length === 0 && (
        <p className="text-center text-foreground/50 py-12">這個篩選條件下沒有預約</p>
      )}

      <div className="flex flex-col gap-6">
        {sortedKeys.map((key) => (
          <div key={key}>
            <h2 className="text-sm font-semibold text-foreground/50 mb-2">{dateHeading(key)}</h2>
            <div className="flex flex-col gap-3">
              {groups.get(key)!.map((a) => {
                const customer = Array.isArray(a.customers) ? a.customers[0] : a.customers;
                const staff = Array.isArray(a.staff) ? a.staff[0] : a.staff;
                const linked = (a.appointment_services ?? [])
                  .map((row) => (Array.isArray(row.services) ? row.services[0] : row.services))
                  .filter((s): s is ServiceRow => !!s);
                const single = Array.isArray(a.services) ? a.services[0] : a.services;
                const services = linked.length > 0 ? linked : single ? [single] : [];
                // 商品券方案（有堂數）是用既有堂數預約，不收費，不要把方案全額算進預約金額
                const totalPrice = services.reduce((sum, s) => sum + (s.total_sessions ? 0 : s.price ?? 0), 0);
                const usesVoucher = services.some((s) => s.total_sessions);
                const maxServiceBuffer = services.reduce(
                  (max, s) => Math.max(max, s.buffer_minutes ?? 0),
                  0
                );

                return (
                  <div key={a.id} className="p-4 border border-primary-light rounded-xl bg-white">
                    <div className="flex items-start justify-between gap-3">
                      <span className="text-lg font-bold text-primary-dark">
                        {new Date(a.start_time).toLocaleTimeString("zh-TW", {
                          timeZone: "Asia/Taipei",
                          hour: "2-digit",
                          minute: "2-digit",
                        })}
                      </span>
                      <div className="flex items-center gap-2">
                        <span
                          className={`text-xs px-2 py-1 rounded-full whitespace-nowrap ${
                            statusStyle[a.status] ?? "bg-gray-100 text-gray-500"
                          }`}
                        >
                          {statusLabel[a.status] ?? a.status}
                        </span>
                        <Link
                          href={`/appointments/day?date=${a.dateKey}`}
                          title="查看這天所有預約"
                          aria-label="查看這天所有預約"
                          className="p-1.5 rounded-lg text-primary-dark hover:bg-primary-light transition-colors"
                        >
                          <CalendarSearch size={18} />
                        </Link>
                      </div>
                    </div>

                    <p className="font-semibold mt-1">
                      {customer?.name}
                      <span className="font-normal text-xs text-foreground/50 ml-2">
                        {customer?.phone}
                      </span>
                      {staff?.name && (
                        <span className="font-normal text-xs text-primary-dark ml-2">
                          指定 {staff.name}
                        </span>
                      )}
                      {(a.party_size ?? 1) > 1 && (
                        <span className="font-normal text-xs px-2 py-0.5 rounded-full bg-orange-100 text-orange-700 ml-2">
                          {a.party_size} 位
                        </span>
                      )}
                    </p>
                    <p className="text-sm text-foreground/70">
                      {services.map((s) => s.name).join("、")}
                      {usesVoucher ? (totalPrice > 0 ? `（商品券＋$${totalPrice}）` : "（商品券）") : `（$${totalPrice}）`}
                    </p>
                    {a.note && (
                      <p className="text-xs text-foreground/50 mt-1">備註：{a.note}</p>
                    )}
                    <p className="text-[11px] text-foreground/40 mt-1">
                      建立時間 {toDateInputValue(a.created_at)} {toTimeInputValue(a.created_at)}
                    </p>

                    <div className="flex flex-wrap items-center gap-2 mt-3">
                      {a.status === "pending" && (
                        <form action={updateAppointmentStatus.bind(null, a.id, "confirmed")}>
                          <button className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg bg-primary-dark text-white hover:bg-primary transition-colors">
                            <Check size={14} /> 確認
                          </button>
                        </form>
                      )}
                      {a.status !== "cancelled" && a.status !== "completed" && (
                        <>
                          <form action={cancelAppointmentQuietly.bind(null, a.id)}>
                            <button
                              title="客人自己要求取消，不會傳訊息給客人，時段會開放給別人預約"
                              className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-gray-300 text-gray-600 hover:bg-gray-50 transition-colors"
                            >
                              <X size={14} /> 客人取消
                            </button>
                          </form>
                          <form action={updateAppointmentStatus.bind(null, a.id, "cancelled")}>
                            <button
                              title="店家排不了，婉拒客人：會傳 LINE 訊息通知客人，時段會開放給別人預約"
                              className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-red-200 text-red-500 hover:bg-red-50 transition-colors"
                            >
                              <X size={14} /> 婉拒預約
                            </button>
                          </form>
                        </>
                      )}
                      {a.status !== "cancelled" && (
                        <Link
                          href={`/checkout?appointment=${a.id}`}
                          className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
                        >
                          <ShoppingCart size={14} /> 開單
                        </Link>
                      )}
                    </div>

                    {a.status !== "cancelled" && (
                    <details className="mt-2 group">
                      <summary className="text-xs text-foreground/50 cursor-pointer select-none inline-flex items-center gap-1 hover:text-primary-dark">
                        <ChevronDown size={12} className="transition-transform group-open:rotate-180" />
                        修改時間／緩衝
                      </summary>
                      <UpdateTimeForm
                        appointmentId={a.id}
                        defaultDate={toDateInputValue(a.start_time)}
                        defaultTime={toTimeInputValue(a.start_time)}
                        defaultBufferHours={Math.floor((a.buffer_minutes ?? maxServiceBuffer) / 60)}
                        defaultBufferMinutes={(a.buffer_minutes ?? maxServiceBuffer) % 60}
                      />
                    </details>
                    )}
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
