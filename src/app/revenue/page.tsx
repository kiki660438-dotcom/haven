import { createClient } from "@/lib/supabase-server";

function monthStartTaipei() {
  const dateStr = new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Taipei",
  }).format(new Date());
  const monthStr = dateStr.slice(0, 7);
  return `${monthStr}-01T00:00:00+08:00`;
}

function dayKeyTaipei(iso: string) {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(
    new Date(iso)
  );
}

async function fetchAllOrders(supabase: Awaited<ReturnType<typeof createClient>>) {
  const pageSize = 1000;
  let from = 0;
  const all: {
    total: number;
    status: string;
    payment_method: string | null;
    created_at: string;
    order_items: { service_name: string; price: number; quantity: number }[];
  }[] = [];

  while (true) {
    const { data, error } = await supabase
      .from("orders")
      .select("total, status, payment_method, created_at, order_items(service_name, price, quantity)")
      .range(from, from + pageSize - 1);

    if (error || !data || data.length === 0) break;
    all.push(...data);
    if (data.length < pageSize) break;
    from += pageSize;
  }

  return all;
}

export default async function RevenuePage() {
  const monthStart = monthStartTaipei();

  const supabase = await createClient();
  const orders = await fetchAllOrders(supabase);

  const paidOrders = orders.filter((o) => o.status === "paid");
  const unpaidOrders = orders.filter((o) => o.status !== "paid");

  const totalRevenue = paidOrders.reduce((sum, o) => sum + o.total, 0);
  const outstanding = unpaidOrders.reduce((sum, o) => sum + o.total, 0);
  const monthRevenue = paidOrders
    .filter((o) => o.created_at >= monthStart)
    .reduce((sum, o) => sum + o.total, 0);

  const cashRevenue = paidOrders
    .filter((o) => o.payment_method === "cash")
    .reduce((sum, o) => sum + o.total, 0);
  const transferRevenue = paidOrders
    .filter((o) => o.payment_method === "transfer")
    .reduce((sum, o) => sum + o.total, 0);

  const byDay = new Map<string, { cash: number; transfer: number; total: number }>();
  for (const o of paidOrders) {
    const day = dayKeyTaipei(o.created_at);
    const entry = byDay.get(day) ?? { cash: 0, transfer: 0, total: 0 };
    entry.total += o.total;
    if (o.payment_method === "cash") entry.cash += o.total;
    if (o.payment_method === "transfer") entry.transfer += o.total;
    byDay.set(day, entry);
  }
  const dailyRevenue = Array.from(byDay.entries())
    .sort((a, b) => b[0].localeCompare(a[0]))
    .slice(0, 14);

  const byService = new Map<string, number>();
  for (const o of paidOrders) {
    for (const item of o.order_items ?? []) {
      byService.set(
        item.service_name,
        (byService.get(item.service_name) ?? 0) + item.price * item.quantity
      );
    }
  }
  const serviceRanking = Array.from(byService.entries())
    .sort((a, b) => b[1] - a[1])
    .slice(0, 10);
  const maxServiceRevenue = serviceRanking[0]?.[1] ?? 1;

  return (
    <main className="max-w-4xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">營業額總覽</h1>

      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-4">
        <div className="p-5 rounded-xl border border-primary-light bg-white">
          <p className="text-sm text-foreground/60 mb-1">累計總營業額</p>
          <p className="text-2xl font-bold text-primary-dark">${totalRevenue}</p>
        </div>
        <div className="p-5 rounded-xl border border-primary-light bg-white">
          <p className="text-sm text-foreground/60 mb-1">本月營業額</p>
          <p className="text-2xl font-bold text-primary-dark">${monthRevenue}</p>
        </div>
        <div className="p-5 rounded-xl border border-primary-light bg-white">
          <p className="text-sm text-foreground/60 mb-1">未收款金額</p>
          <p className="text-2xl font-bold text-primary-dark">${outstanding}</p>
        </div>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-8">
        <div className="p-5 rounded-xl border border-primary-light bg-white">
          <p className="text-sm text-foreground/60 mb-1">現金收入</p>
          <p className="text-xl font-bold text-primary-dark">${cashRevenue}</p>
        </div>
        <div className="p-5 rounded-xl border border-primary-light bg-white">
          <p className="text-sm text-foreground/60 mb-1">匯款收入</p>
          <p className="text-xl font-bold text-primary-dark">${transferRevenue}</p>
        </div>
      </div>

      <h2 className="font-semibold mb-3">日營業額（近 14 天）</h2>
      <div className="overflow-x-auto mb-8">
      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">日期</th>
            <th className="px-3">現金</th>
            <th className="px-3">匯款</th>
            <th className="px-3">當日總計</th>
          </tr>
        </thead>
        <tbody>
          {dailyRevenue.map(([day, v]) => (
            <tr key={day} className="border-b border-primary-light/60">
              <td className="py-2 px-3">{day}</td>
              <td className="px-3">${v.cash}</td>
              <td className="px-3">${v.transfer}</td>
              <td className="px-3 font-semibold">${v.total}</td>
            </tr>
          ))}
          {dailyRevenue.length === 0 && (
            <tr>
              <td colSpan={4} className="py-6 px-3 text-center text-foreground/50">
                還沒有已付款的訂單資料
              </td>
            </tr>
          )}
        </tbody>
      </table>
      </div>

      <h2 className="font-semibold mb-3">服務項目營業額排行</h2>
      <div className="flex flex-col gap-2">
        {serviceRanking.map(([name, revenue]) => (
          <div key={name} className="flex items-center gap-3">
            <span className="w-24 text-sm text-foreground/70 shrink-0">{name}</span>
            <div className="flex-1 bg-primary-light rounded-full h-5 overflow-hidden">
              <div
                className="bg-primary-dark h-full rounded-full"
                style={{ width: `${(revenue / maxServiceRevenue) * 100}%` }}
              />
            </div>
            <span className="w-20 text-sm text-right shrink-0">${revenue}</span>
          </div>
        ))}
        {serviceRanking.length === 0 && (
          <p className="text-center text-foreground/50 py-6">還沒有已付款的訂單資料</p>
        )}
      </div>
    </main>
  );
}
