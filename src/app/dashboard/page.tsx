import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { fetchAllRows } from "@/lib/fetch-all";
import { updateAppointmentStatus } from "../appointments/actions";
import { ChevronLeft, ChevronRight } from "lucide-react";

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

// "2026-10" 加減幾個月
function shiftMonth(month: string, delta: number) {
  const [y, m] = month.split("-").map(Number);
  const d = new Date(Date.UTC(y, m - 1 + delta, 1));
  return `${d.getUTCFullYear()}-${String(d.getUTCMonth() + 1).padStart(2, "0")}`;
}

const statusLabel: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  cancelled: "已取消",
  completed: "已完成",
};

export default async function DashboardPage({
  searchParams,
}: {
  searchParams: Promise<{ month?: string }>;
}) {
  const { start, end, dateStr } = todayRangeTaipei();
  const currentMonth = dateStr.slice(0, 7);
  const { month: monthParam } = await searchParams;
  const month = monthParam && /^\d{4}-\d{2}$/.test(monthParam) ? monthParam : currentMonth;
  const supabase = await createClient();

  // 每月營業額：選定月份的所有已付款訂單（一頁一頁抓完，訂單多也不會漏）
  const monthOrders = await fetchAllRows((from, to) =>
    supabase
      .from("orders")
      .select("id, total, payment_method, created_at")
      .eq("status", "paid")
      .gte("created_at", `${month}-01T00:00:00+08:00`)
      .lt("created_at", `${shiftMonth(month, 1)}-01T00:00:00+08:00`)
      .order("created_at")
      .order("id")
      .range(from, to)
  );
  const monthRevenue = monthOrders.reduce((sum, o) => sum + o.total, 0);
  const monthCash = monthOrders
    .filter((o) => o.payment_method === "cash")
    .reduce((sum, o) => sum + o.total, 0);
  const monthTransfer = monthOrders
    .filter((o) => o.payment_method === "transfer")
    .reduce((sum, o) => sum + o.total, 0);
  // 沒記付款方式的（例如舊資料、只扣商品券 $0 的單）
  const monthOther = monthRevenue - monthCash - monthTransfer;
  const [monthY, monthM] = month.split("-").map(Number);

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
      .select("total, status, payment_method")
      .gte("created_at", start)
      .lte("created_at", end),
  ]);

  const todayOrderCount = todayOrders?.length ?? 0;
  const todayRevenue =
    todayOrders
      ?.filter((o) => o.status === "paid")
      .reduce((sum, o) => sum + o.total, 0) ?? 0;

  const paidToday = todayOrders?.filter((o) => o.status === "paid") ?? [];
  const todayCash = paidToday.filter((o) => o.payment_method === "cash").reduce((sum, o) => sum + o.total, 0);
  const todayTransfer = paidToday
    .filter((o) => o.payment_method === "transfer")
    .reduce((sum, o) => sum + o.total, 0);

  const cards = [
    { label: "今日預約", value: todayAppointmentList?.length ?? 0 },
    { label: "待確認預約", value: pendingAppointments ?? 0 },
    { label: "今日開單數", value: todayOrderCount },
    { label: "今日營業額", value: `$${todayRevenue.toLocaleString()}` },
    { label: "今日現金", value: `$${todayCash.toLocaleString()}` },
    { label: "今日匯款", value: `$${todayTransfer.toLocaleString()}` },
  ];

  return (
    <main className="max-w-4xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-1">營業總覽</h1>
      <p className="text-sm text-foreground/50 mb-6">{dateStr}</p>

      <div className="grid grid-cols-2 sm:grid-cols-3 gap-4 mb-8">
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

      <section className="mb-8 p-5 rounded-xl border border-primary-light bg-white">
        <div className="flex items-center justify-between gap-2 mb-4 flex-wrap">
          <h2 className="font-semibold">每月營業額</h2>
          <div className="flex items-center gap-1">
            <Link
              href={`/dashboard?month=${shiftMonth(month, -1)}`}
              aria-label="上個月"
              className="p-2 rounded-lg hover:bg-primary-light text-primary-dark touch-manipulation"
            >
              <ChevronLeft size={18} />
            </Link>
            <form method="GET" action="/dashboard">
              <input
                type="month"
                name="month"
                defaultValue={month}
                key={month}
                className="border border-primary-light rounded-lg px-2 py-1.5 text-sm"
              />
              <button type="submit" className="ml-1 text-sm text-primary-dark underline">
                查詢
              </button>
            </form>
            <Link
              href={`/dashboard?month=${shiftMonth(month, 1)}`}
              aria-label="下個月"
              className="p-2 rounded-lg hover:bg-primary-light text-primary-dark touch-manipulation"
            >
              <ChevronRight size={18} />
            </Link>
          </div>
        </div>

        <p className="text-sm text-foreground/60 mb-3">
          {monthY} 年 {monthM} 月・共 {monthOrders.length} 筆已付款訂單
          {month !== currentMonth && (
            <Link href="/dashboard" className="ml-2 underline text-primary-dark">
              回到本月
            </Link>
          )}
        </p>

        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
          <div className="p-4 rounded-xl bg-primary-light/50">
            <p className="text-sm text-foreground/60 mb-1">總營業額</p>
            <p className="text-2xl font-bold text-primary-dark">${monthRevenue.toLocaleString()}</p>
          </div>
          <div className="p-4 rounded-xl bg-primary-light/50">
            <p className="text-sm text-foreground/60 mb-1">現金</p>
            <p className="text-2xl font-bold text-primary-dark">${monthCash.toLocaleString()}</p>
          </div>
          <div className="p-4 rounded-xl bg-primary-light/50">
            <p className="text-sm text-foreground/60 mb-1">匯款</p>
            <p className="text-2xl font-bold text-primary-dark">${monthTransfer.toLocaleString()}</p>
          </div>
        </div>
        {monthOther !== 0 && (
          <p className="text-xs text-foreground/50 mt-3">
            另有 ${monthOther.toLocaleString()} 沒有記錄付款方式（例如舊資料），已算在總營業額裡。
          </p>
        )}
      </section>

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
