import { createClient } from "@/lib/supabase-server";

export default async function MemberDetailPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const supabase = await createClient();

  const { data: customer } = await supabase
    .from("customers")
    .select("*")
    .eq("id", id)
    .single();

  const { data: orders } = await supabase
    .from("orders")
    .select("id, total, status, created_at, order_items(service_name, price, quantity)")
    .eq("customer_id", id)
    .order("created_at", { ascending: false });

  const totalSpent =
    orders?.filter((o) => o.status === "paid").reduce((s, o) => s + o.total, 0) ?? 0;

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-1">{customer?.name}</h1>
      <p className="text-sm text-foreground/50 mb-6">
        {customer?.phone} ・ 累計消費 ${totalSpent}
      </p>

      <div className="flex flex-col gap-4">
        {orders?.map((o) => (
          <div key={o.id} className="p-4 border border-primary-light rounded-xl bg-white">
            <div className="flex justify-between items-start mb-2">
              <p className="text-xs text-foreground/50">
                {new Date(o.created_at).toLocaleString("zh-TW", {
                  timeZone: "Asia/Taipei",
                })}
              </p>
              <span
                className={`text-sm px-2 py-1 rounded-full ${
                  o.status === "paid"
                    ? "bg-primary-light text-primary-dark"
                    : "bg-yellow-100 text-yellow-700"
                }`}
              >
                {o.status === "paid" ? "已付款" : "未付款"}
              </span>
            </div>
            <ul className="text-sm text-foreground/70 mb-2">
              {o.order_items?.map((it, idx) => (
                <li key={idx}>
                  {it.service_name} x{it.quantity} — ${it.price * it.quantity}
                </li>
              ))}
            </ul>
            <p className="font-bold">總計 ${o.total}</p>
          </div>
        ))}
        {orders?.length === 0 && (
          <p className="text-center text-foreground/50 py-6">還沒有消費紀錄</p>
        )}
      </div>
    </main>
  );
}
