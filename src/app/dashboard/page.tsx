import { createClient } from "@/lib/supabase-server";

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

export default async function DashboardPage() {
  const { start, end, dateStr } = todayRangeTaipei();
  const supabase = await createClient();

  const [
    { count: todayAppointments },
    { count: pendingAppointments },
    { data: todayOrders },
  ] = await Promise.all([
    supabase
      .from("appointments")
      .select("*", { count: "exact", head: true })
      .gte("start_time", start)
      .lte("start_time", end),
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
    { label: "今日預約", value: todayAppointments ?? 0 },
    { label: "待確認預約", value: pendingAppointments ?? 0 },
    { label: "今日開單數", value: todayOrderCount },
    { label: "今日營業額", value: `$${todayRevenue}` },
  ];

  return (
    <main className="max-w-4xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-1">營業總覽</h1>
      <p className="text-sm text-foreground/50 mb-6">{dateStr}</p>

      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
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
    </main>
  );
}
