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
      .select("id, start_time, status, customers(name, phone), services(name, price)")
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

      <div className="overflow-x-auto">
      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">時間</th>
            <th className="px-3">客戶</th>
            <th className="px-3">服務</th>
            <th className="px-3">狀態</th>
            <th className="px-3"></th>
          </tr>
        </thead>
        <tbody>
          {todayAppointmentList?.map((a) => {
            const customer = Array.isArray(a.customers) ? a.customers[0] : a.customers;
            const service = Array.isArray(a.services) ? a.services[0] : a.services;
            return (
              <tr key={a.id} className="border-b border-primary-light/60">
                <td className="py-2 px-3">
                  {new Date(a.start_time).toLocaleTimeString("zh-TW", {
                    timeZone: "Asia/Taipei",
                    hour: "2-digit",
                    minute: "2-digit",
                  })}
                </td>
                <td className="px-3">
                  {customer?.name}
                  <br />
                  <span className="text-xs text-foreground/50">{customer?.phone}</span>
                </td>
                <td className="px-3">{service?.name}</td>
                <td className="px-3">{statusLabel[a.status] ?? a.status}</td>
                <td className="px-3">
                  <div className="flex flex-wrap gap-2">
                    <form action={updateAppointmentStatus.bind(null, a.id, "confirmed")}>
                      <button className="text-primary-dark text-sm">確認</button>
                    </form>
                    <form action={updateAppointmentStatus.bind(null, a.id, "cancelled")}>
                      <button className="text-red-500 text-sm">取消</button>
                    </form>
                    <Link
                      href={`/checkout?appointment=${a.id}`}
                      className="text-sm underline text-primary-dark"
                    >
                      開單
                    </Link>
                  </div>
                </td>
              </tr>
            );
          })}
          {todayAppointmentList?.length === 0 && (
            <tr>
              <td colSpan={5} className="py-6 px-3 text-center text-foreground/50">
                今天還沒有預約
              </td>
            </tr>
          )}
        </tbody>
      </table>
      </div>
    </main>
  );
}
