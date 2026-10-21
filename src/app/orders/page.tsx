import Link from "next/link";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { createClient } from "@/lib/supabase-server";
import OrdersList, { type OrderRow } from "./OrdersList";

function taipeiMonthNow() {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date()).slice(0, 7);
}

function shiftMonth(month: string, delta: number) {
  const [y, m] = month.split("-").map(Number);
  const d = new Date(Date.UTC(y, m - 1 + delta, 1));
  return `${d.getUTCFullYear()}-${String(d.getUTCMonth() + 1).padStart(2, "0")}`;
}

const labelFmt = new Intl.DateTimeFormat("zh-TW", {
  timeZone: "Asia/Taipei",
  year: "numeric",
  month: "2-digit",
  day: "2-digit",
  hour: "2-digit",
  minute: "2-digit",
  hourCycle: "h23",
});

const localFmt = new Intl.DateTimeFormat("sv-SE", {
  timeZone: "Asia/Taipei",
  year: "numeric",
  month: "2-digit",
  day: "2-digit",
  hour: "2-digit",
  minute: "2-digit",
  hourCycle: "h23",
});

export default async function OrdersPage({
  searchParams,
}: {
  searchParams: Promise<{ success?: string; month?: string }>;
}) {
  const { success, month: monthParam } = await searchParams;
  const current = taipeiMonthNow();
  const month = monthParam && /^\d{4}-\d{2}$/.test(monthParam) ? monthParam : current;
  const next = shiftMonth(month, 1);

  const supabase = await createClient();
  const { data } = await supabase
    .from("orders")
    .select(
      "id, total, status, payment_method, customer_name, created_at, customers(name, phone), order_items(service_id, service_name, price, quantity, unit_cost)"
    )
    .gte("created_at", `${month}-01T00:00:00+08:00`)
    .lt("created_at", `${next}-01T00:00:00+08:00`)
    .order("created_at", { ascending: false });

  const orders: OrderRow[] = (data ?? []).map((o) => {
    const customer = Array.isArray(o.customers) ? o.customers[0] : o.customers;
    const items = (o.order_items ?? []) as OrderRow["items"];
    return {
      id: o.id,
      createdLabel: labelFmt.format(new Date(o.created_at)),
      createdLocal: localFmt.format(new Date(o.created_at)).replace(" ", "T"),
      total: o.total,
      status: o.status,
      paymentMethod: o.payment_method,
      customerName: customer?.name ?? o.customer_name ?? "",
      phone: customer?.phone ?? "",
      items,
      cost: items.reduce((sum, it) => sum + (it.unit_cost ?? 0) * it.quantity, 0),
    };
  });

  const paid = orders.filter((o) => o.status === "paid");
  const revenue = paid.reduce((s, o) => s + o.total, 0);
  const cash = paid.filter((o) => o.paymentMethod === "cash").reduce((s, o) => s + o.total, 0);
  const transfer = paid.filter((o) => o.paymentMethod === "transfer").reduce((s, o) => s + o.total, 0);

  const [y, m] = month.split("-");

  return (
    <main className="max-w-3xl mx-auto p-4 sm:p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-4">訂單紀錄</h1>

      {success && (
        <div className="mb-4 p-4 rounded-xl bg-primary-light text-primary-dark">訂單建立成功！</div>
      )}

      <div className="flex items-center justify-between mb-4">
        <Link
          href={`/orders?month=${shiftMonth(month, -1)}`}
          aria-label="上個月"
          className="p-2 rounded-full hover:bg-primary-light text-primary-dark"
        >
          <ChevronLeft size={18} />
        </Link>
        <div className="flex items-center gap-3">
          <span className="font-semibold text-lg">
            {y} 年 {Number(m)} 月
          </span>
          {month !== current && (
            <Link href="/orders" className="text-xs px-2.5 py-1 rounded-full bg-primary-light text-primary-dark">
              回本月
            </Link>
          )}
        </div>
        <Link
          href={`/orders?month=${next}`}
          aria-label="下個月"
          className="p-2 rounded-full hover:bg-primary-light text-primary-dark"
        >
          <ChevronRight size={18} />
        </Link>
      </div>

      <div className="grid grid-cols-4 gap-2 mb-5 text-center">
        <div className="p-3 rounded-xl bg-primary-light">
          <p className="text-lg font-bold text-primary-dark">{orders.length}</p>
          <p className="text-xs text-foreground/60">訂單數</p>
        </div>
        <div className="p-3 rounded-xl bg-primary-light">
          <p className="text-lg font-bold text-primary-dark">${revenue.toLocaleString()}</p>
          <p className="text-xs text-foreground/60">營收</p>
        </div>
        <div className="p-3 rounded-xl bg-primary-light">
          <p className="text-lg font-bold text-primary-dark">${cash.toLocaleString()}</p>
          <p className="text-xs text-foreground/60">現金</p>
        </div>
        <div className="p-3 rounded-xl bg-primary-light">
          <p className="text-lg font-bold text-primary-dark">${transfer.toLocaleString()}</p>
          <p className="text-xs text-foreground/60">匯款</p>
        </div>
      </div>

      <OrdersList key={month} orders={orders} />
    </main>
  );
}
