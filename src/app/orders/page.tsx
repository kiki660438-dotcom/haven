import { createClient } from "@/lib/supabase-server";
import { markOrderPaid } from "../checkout/actions";

export default async function OrdersPage({
  searchParams,
}: {
  searchParams: Promise<{ success?: string }>;
}) {
  const { success } = await searchParams;
  const supabase = await createClient();

  const { data: orders } = await supabase
    .from("orders")
    .select("id, total, status, payment_method, customer_name, created_at, customers(name), order_items(service_name, price, quantity)")
    .order("created_at", { ascending: false });

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">訂單紀錄</h1>

      {success && (
        <div className="mb-6 p-4 rounded-xl bg-primary-light text-primary-dark">
          訂單建立成功！
        </div>
      )}

      <div className="flex flex-col gap-4">
        {orders?.map((o) => {
          const customer = Array.isArray(o.customers) ? o.customers[0] : o.customers;
          return (
            <div
              key={o.id}
              className="p-4 border border-primary-light rounded-xl bg-white"
            >
              <div className="flex justify-between items-start mb-2">
                <div>
                  <p className="font-semibold">
                    {customer?.name ?? o.customer_name ?? "現場客"}
                  </p>
                  <p className="text-xs text-foreground/50">
                    {new Date(o.created_at).toLocaleString("zh-TW", {
                      timeZone: "Asia/Taipei",
                    })}
                  </p>
                </div>
                <span
                  className={`text-sm px-2 py-1 rounded-full ${
                    o.status === "paid"
                      ? "bg-primary-light text-primary-dark"
                      : "bg-yellow-100 text-yellow-700"
                  }`}
                >
                  {o.status === "paid"
                    ? `已付款・${o.payment_method === "cash" ? "現金" : "匯款"}`
                    : "未付款"}
                </span>
              </div>
              <ul className="text-sm text-foreground/70 mb-2">
                {o.order_items?.map((it, idx) => (
                  <li key={idx}>
                    {it.service_name} x{it.quantity} — ${it.price * it.quantity}
                  </li>
                ))}
              </ul>
              <div className="flex justify-between items-center">
                <p className="font-bold">總計 ${o.total}</p>
                {o.status !== "paid" && (
                  <div className="flex gap-3">
                    <form action={markOrderPaid.bind(null, o.id, "cash")}>
                      <button className="text-primary-dark text-sm underline">
                        現金付款
                      </button>
                    </form>
                    <form action={markOrderPaid.bind(null, o.id, "transfer")}>
                      <button className="text-primary-dark text-sm underline">
                        匯款付款
                      </button>
                    </form>
                  </div>
                )}
              </div>
            </div>
          );
        })}
        {orders?.length === 0 && (
          <p className="text-center text-foreground/50 py-6">還沒有訂單紀錄</p>
        )}
      </div>
    </main>
  );
}
