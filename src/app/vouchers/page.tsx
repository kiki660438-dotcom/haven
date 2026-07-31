import { createClient } from "@/lib/supabase-server";

const statusLabel: Record<string, string> = {
  active: "可使用",
  used: "已用完",
  expired: "已過期",
};

export default async function VouchersPage() {
  const supabase = await createClient();
  const { data: vouchers } = await supabase
    .from("vouchers")
    .select(
      "id, code, initial_value, remaining_value, status, expires_at, service_name, total_sessions, remaining_sessions, purchased_at, unit_price, duration_minutes, customers(name, phone)"
    )
    .order("issued_at", { ascending: false });

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-2">商品券</h1>
      <p className="text-sm text-foreground/50 mb-6">
        新購與扣堂數請到「開單結帳」操作，這裡僅供查詢。
      </p>

      <div className="flex flex-col gap-3">
        {vouchers?.map((v) => {
          const customer = Array.isArray(v.customers) ? v.customers[0] : v.customers;
          const isSessionVoucher = v.total_sessions != null;
          return (
            <div
              key={v.id}
              className="p-4 border border-primary-light rounded-xl bg-white flex items-center justify-between gap-4"
            >
              <div>
                <p className="font-mono font-semibold">
                  {v.service_name ?? v.code}
                </p>
                <p className="text-sm text-foreground/60">
                  {customer ? `${customer.name}（${customer.phone}）` : "通用券"}
                  {isSessionVoucher ? (
                    <>
                      {" "}
                      ・ 剩餘 {v.remaining_sessions} / {v.total_sessions} 堂 ・ 面額 $
                      {v.initial_value}
                    </>
                  ) : (
                    <>
                      {" "}
                      ・ 剩餘 ${v.remaining_value} / ${v.initial_value}
                    </>
                  )}
                  {v.purchased_at && <> ・ 購買於 {v.purchased_at}</>}
                  {v.expires_at && <> ・ 效期至 {v.expires_at}</>}
                </p>
              </div>
              <span className="text-sm text-primary-dark shrink-0">
                {statusLabel[v.status] ?? v.status}
              </span>
            </div>
          );
        })}
        {vouchers?.length === 0 && (
          <p className="text-center text-foreground/50 py-6">還沒有商品券</p>
        )}
      </div>
    </main>
  );
}
