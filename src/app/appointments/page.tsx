import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { updateAppointmentStatus } from "./actions";
import UpdateTimeForm from "./UpdateTimeForm";
import { Check, X, ShoppingCart, ChevronDown, Calendar } from "lucide-react";

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

type ServiceRow = { name: string; price: number; buffer_minutes: number | null };

export default async function AppointmentsPage({
  searchParams,
}: {
  searchParams: Promise<{ filter?: string; date?: string }>;
}) {
  const { filter, date } = await searchParams;
  const activeFilter = date ? "date" : filter ?? "upcoming";

  const supabase = await createClient();
  const { data: appointments } = await supabase
    .from("appointments")
    .select(
      "id, start_time, status, buffer_minutes, customers(name, phone), staff(name), services(name, price, buffer_minutes), appointment_services(services(name, price, buffer_minutes))"
    )
    .order("start_time", { ascending: true });

  const today = todayKey();
  const pendingCount = appointments?.filter((a) => a.status === "pending").length ?? 0;

  const withKey = (appointments ?? []).map((a) => ({
    ...a,
    dateKey: new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date(a.start_time)),
  }));

  const filtered = withKey.filter((a) => {
    if (activeFilter === "date") return a.dateKey === date;
    if (activeFilter === "pending") return a.status === "pending";
    if (activeFilter === "today") return a.dateKey === today && a.status !== "cancelled";
    if (activeFilter === "all") return true;
    return a.dateKey >= today && a.status !== "cancelled";
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
  ];

  return (
    <main className="max-w-3xl mx-auto p-8">
      <div className="flex items-center justify-between mb-4 flex-wrap gap-3">
        <h1 className="text-2xl font-bold text-primary-dark">預約管理</h1>
        <Link
          href="/appointments/calendar"
          className="inline-flex items-center gap-1.5 text-sm px-3 py-1.5 rounded-full border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
        >
          <Calendar size={14} /> 月曆檢視
        </Link>
      </div>

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
                const totalPrice = services.reduce((sum, s) => sum + (s.price ?? 0), 0);
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
                      <span
                        className={`text-xs px-2 py-1 rounded-full whitespace-nowrap ${
                          statusStyle[a.status] ?? "bg-gray-100 text-gray-500"
                        }`}
                      >
                        {statusLabel[a.status] ?? a.status}
                      </span>
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
                    </p>
                    <p className="text-sm text-foreground/70">
                      {services.map((s) => s.name).join("、")}（${totalPrice}）
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
                        <form action={updateAppointmentStatus.bind(null, a.id, "cancelled")}>
                          <button className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-red-200 text-red-500 hover:bg-red-50 transition-colors">
                            <X size={14} /> 取消
                          </button>
                        </form>
                      )}
                      <Link
                        href={`/checkout?appointment=${a.id}`}
                        className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
                      >
                        <ShoppingCart size={14} /> 開單
                      </Link>
                    </div>

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
