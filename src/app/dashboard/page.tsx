import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { updateAppointmentStatus } from "../appointments/actions";

function todayRangeTaipei() {
  const dateStr = new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Taipei",
  }).format(new Date()); // YYYY-MM-DD
  return {
    start: `${dateStr}T00:00:00+08:00`,
    end: `${dateStr}T23:59:59+08:00`,
    dateStr,
  };
}

const statusLabel: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  cancelled: "已取消",
  completed: "已完成",
};

export default async function DashboardPage() {
  const { start, end, dateStr } = todayRangeTaipei();
  const supabase = await createClient();

  const [
    { data: todayAppointmentList },
    { count: pendingAppointments },
    { data: todayOrders },
  ] = await Promise.all([
    supabase
      .from("appointments")
      .select(
        "id, start_time, status, customers(name, phone), services(name, price), appointment_services(services(name, price))"
      )
      .gte("start_time", start)
      .lte("start_time", end)
      .order("start_time", { ascending: true }),
    supabase
      .from("appointments")
      .select("*", { count: "exact", head: true })
      .eq("status", "pending"),
    supabase
      .from("orders")
      .select("total, status")
      .gte("created_at", start)
      .lte("created_at", end),
  ]);

  const todayOrderCount = todayOrders?.length ?? 0;
  const todayRevenue =
    todayOrders
      ?.filter((o) => o.status === "paid")
      .reduce((sum, o) => sum + o.total, 0) ?? 0;

  const cards = [
    { label: "今日預約", value: todayAppointmentList?.length ?? 0 },
    { label: "待確認預約", value: pendingAppointments ?? 0 },
    { label: "今日開單數", value: todayOrderCount },
    { label: "今日營業額", value: `$${todayRevenue}` },
  ];

  return (
    <main className="max-w-4xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-1">營業總覽</h1>
      <p className="text-sm text-foreground/50 mb-6">{dateStr}</p>

      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-8">
        {cards.map((c) => (
          <div
            key={c.label}
            className="p-5 rounded-xl border border-primary-light bg-white"
          >
            <p className="text-sm text-foreground/60 mb-1">{c.label}</p>
            <p className="text-2xl font-bold text-primary-dark">{c.value}</p>
          </div>
        ))}
      </div>

      <div className="flex items-center justify-between mb-3">
        <h2 className="font-semibold">今日預約名單</h2>
        <Link href="/appointments" className="text-sm underline text-primary-dark">
          查看全部預約
        </Link>
      </div>

      <div className="flex flex-col gap-3">
        {todayAppointmentList?.map((a) => {
          const customer = Array.isArray(a.customers) ? a.customers[0] : a.customers;
          const linked = (a.appointment_services ?? [])
            .map((row) => (Array.isArray(row.services) ? row.services[0] : row.services))
            .filter((s): s is { name: string; price: number } => !!s);
          const single = Array.isArray(a.services) ? a.services[0] : a.services;
          const services = linked.length > 0 ? linked : single ? [single] : [];
          return (
            <div key={a.id} className="p-4 border border-primary-light rounded-xl bg-white">
              <div className="flex justify-between items-start mb-2 gap-3">
                <div>
                  <p className="font-semibold">
                    {customer?.name}
                    <span className="font-normal text-xs text-foreground/50 ml-2">
                      {customer?.phone}
                    </span>
                  </p>
                  <p className="text-sm text-foreground/70">{services.map((s) => s.name).join("、")}</p>
                  <p className="text-xs text-foreground/50">
                    {new Date(a.start_time).toLocaleTimeString("zh-TW", {
                      timeZone: "Asia/Taipei",
                      hour: "2-digit",
                      minute: "2-digit",
                    })}
                  </p>
                </div>
                <span
                  className={`text-sm px-2 py-1 rounded-full whitespace-nowrap ${
                    a.status === "confirmed"
                      ? "bg-primary-light text-primary-dark"
                      : a.status === "cancelled"
                      ? "bg-red-50 text-red-500"
                      : a.status === "completed"
                      ? "bg-primary-light text-primary-dark"
                      : "bg-yellow-100 text-yellow-700"
                  }`}
                >
                  {statusLabel[a.status] ?? a.status}
                </span>
              </div>
              <div className="flex flex-wrap gap-3">
                <form action={updateAppointmentStatus.bind(null, a.id, "confirmed")}>
                  <button className="text-primary-dark text-sm underline">確認</button>
                </form>
                <form action={updateAppointmentStatus.bind(null, a.id, "cancelled")}>
                  <button className="text-red-500 text-sm underline">取消</button>
                </form>
                <Link
                  href={`/checkout?appointment=${a.id}`}
                  className="text-sm underline text-primary-dark"
                >
                  開單
                </Link>
              </div>
            </div>
          );
        })}
        {todayAppointmentList?.length === 0 && (
          <p className="text-center text-foreground/50 py-6">今天還沒有預約</p>
        )}
      </div>
    </main>
  );
}
