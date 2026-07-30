import { createClient } from "@/lib/supabase-server";
import { issueVoucher, redeemVoucher } from "./actions";

const statusLabel: Record<string, string> = {
  active: "可使用",
  used: "已用完",
  expired: "已過期",
};

export default async function VouchersPage() {
  const supabase = await createClient();
  const [{ data: customers }, { data: vouchers }] = await Promise.all([
    supabase.from("customers").select("id, name, phone").order("name"),
    supabase
      .from("vouchers")
      .select("id, code, initial_value, remaining_value, status, expires_at, customers(name)")
      .order("issued_at", { ascending: false }),
  ]);

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">商品卷</h1>

      <form
        action={issueVoucher}
        className="grid grid-cols-2 gap-3 mb-8 p-4 border border-primary-light rounded-xl bg-white"
      >
        <select
          name="customer_id"
          className="border border-primary-light rounded-lg px-3 py-2 col-span-2 focus:outline-none focus:border-primary"
        >
          <option value="">不指定客戶（通用券）</option>
          {customers?.map((c) => (
            <option key={c.id} value={c.id}>
              {c.name}（{c.phone}）
            </option>
          ))}
        </select>
        <input
          name="initial_value"
          type="number"
          placeholder="面額 *"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="expires_at"
          type="date"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <button
          type="submit"
          className="col-span-2 bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          發行商品卷
        </button>
      </form>

      <div className="flex flex-col gap-3">
        {vouchers?.map((v) => {
          const customer = Array.isArray(v.customers) ? v.customers[0] : v.customers;
          return (
            <div
              key={v.id}
              className="p-4 border border-primary-light rounded-xl bg-white flex items-center justify-between gap-4"
            >
              <div>
                <p className="font-mono font-semibold">{v.code}</p>
                <p className="text-sm text-foreground/60">
                  {customer?.name ?? "通用券"} ・ 剩餘 ${v.remaining_value} / ${v.initial_value}
                  {v.expires_at && <> ・ 效期至 {v.expires_at}</>}
                </p>
              </div>
              <div className="flex items-center gap-3">
                <span className="text-sm text-primary-dark">{statusLabel[v.status] ?? v.status}</span>
                {v.status === "active" && (
                  <form action={redeemVoucher.bind(null, v.id)} className="flex items-center gap-2">
                    <input
                      type="number"
                      name="amount"
                      placeholder="使用金額"
                      min={1}
                      max={v.remaining_value}
                      required
                      className="w-24 border border-primary-light rounded-lg px-2 py-1"
                    />
                    <button type="submit" className="text-sm underline text-primary-dark">
                      使用
                    </button>
                  </form>
                )}
              </div>
            </div>
          );
        })}
        {vouchers?.length === 0 && (
          <p className="text-center text-foreground/50 py-6">還沒有商品卷</p>
        )}
      </div>
    </main>
  );
}
