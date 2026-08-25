import { createClient } from "@/lib/supabase-server";
import { createOrder } from "./actions";
import { useSession } from "../vouchers/actions";
import CustomerPicker from "./CustomerPicker";

export default async function CheckoutPage({
  searchParams,
}: {
  searchParams: Promise<{ appointment?: string; customer_id?: string }>;
}) {
  const { appointment: appointmentId, customer_id: selectedCustomerId } = await searchParams;
  const supabase = await createClient();

  const [{ data: customers }, { data: services }, { data: staffList }] = await Promise.all([
    supabase.from("customers").select("id, name, phone").order("name"),
    supabase.from("services").select("*").order("name"),
    supabase.from("staff").select("*").eq("active", true).order("name"),
  ]);

  let appointment = null;
  if (appointmentId) {
    const { data } = await supabase
      .from("appointments")
      .select("id, customer_id, service_id")
      .eq("id", appointmentId)
      .maybeSingle();
    appointment = data;
  }

  const customerId = appointment?.customer_id ?? selectedCustomerId ?? "";
  const selectedCustomer = customers?.find((c) => c.id === customerId);
  const customerLabel = selectedCustomer
    ? `${selectedCustomer.name}（${selectedCustomer.phone ?? ""}）`
    : undefined;

  const regularServices = services?.filter((s) => !s.total_sessions) ?? [];
  const packageServices = services?.filter((s) => s.total_sessions) ?? [];

  let activeVouchersByServiceName = new Map<
    string,
    { id: string; remaining_sessions: number; total_sessions: number }
  >();
  if (customerId) {
    const { data } = await supabase
      .from("vouchers")
      .select("id, service_name, total_sessions, remaining_sessions")
      .eq("customer_id", customerId)
      .eq("status", "active")
      .gt("remaining_sessions", 0);
    for (const v of data ?? []) {
      if (v.service_name) {
        activeVouchersByServiceName.set(v.service_name, {
          id: v.id,
          remaining_sessions: v.remaining_sessions,
          total_sessions: v.total_sessions,
        });
      }
    }
  }

  return (
    <main className="max-w-2xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">開單結帳</h1>

      {!appointment && (
        <form
          method="GET"
          action="/checkout"
          className="flex flex-col gap-3 mb-6 p-4 border border-primary-light rounded-xl bg-white"
        >
          <label className="block text-sm text-foreground/60">選擇客戶查看商品券</label>
          <CustomerPicker
            customers={customers ?? []}
            name="customer_id"
            defaultCustomerId={customerId}
            defaultLabel={customerLabel}
          />
          <button
            type="submit"
            className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
          >
            查詢
          </button>
        </form>
      )}

      <form
        action={createOrder}
        className="flex flex-col gap-5 p-5 border border-primary-light rounded-xl bg-white"
      >
        {appointment && (
          <input type="hidden" name="appointment_id" value={appointment.id} />
        )}

        <div>
          <label className="block text-sm mb-1 text-foreground/60">選擇客戶</label>
          <CustomerPicker
            customers={customers ?? []}
            name="customer_id"
            defaultCustomerId={customerId}
            defaultLabel={customerLabel}
          />
        </div>

        <input
          name="customer_name"
          placeholder="現場客姓名（若上面沒選客戶可填這裡）"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />

        <div>
          <label className="block text-sm mb-1 text-foreground/60">服務人員（用於計算業績抽成）</label>
          <select
            name="staff_id"
            defaultValue=""
            className="w-full border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
          >
            <option value="">未指定</option>
            {staffList?.map((s) => (
              <option key={s.id} value={s.id}>
                {s.name}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label className="block text-sm mb-2 text-foreground/60">服務項目</label>
          <div className="flex flex-col gap-2">
            {regularServices.map((s) => (
              <div
                key={s.id}
                className="flex items-center justify-between gap-3 p-3 border border-primary-light rounded-lg"
              >
                <span>
                  {s.name}
                  <span className="text-foreground/50 text-sm"> (${s.price})</span>
                </span>
                <input
                  type="number"
                  name={`qty_${s.id}`}
                  min={0}
                  defaultValue={appointment?.service_id === s.id ? 1 : 0}
                  className="w-20 border border-primary-light rounded-lg px-2 py-1 text-center"
                />
              </div>
            ))}
          </div>
        </div>

        <div>
          <label className="block text-sm mb-2 text-foreground/60">商品券方案</label>
          <div className="flex flex-col gap-2">
            {packageServices.map((s) => {
              const active = activeVouchersByServiceName.get(s.name);
              return (
                <div
                  key={s.id}
                  className="flex items-center justify-between gap-3 p-3 border border-primary-light rounded-lg"
                >
                  <div>
                    <span>
                      {s.name}
                      <span className="text-foreground/50 text-sm">
                        {" "}
                        (${s.price} / {s.total_sessions}堂)
                      </span>
                    </span>
                    {active && (
                      <p className="text-xs text-primary-dark">
                        剩餘 {active.remaining_sessions} / {active.total_sessions} 堂
                      </p>
                    )}
                  </div>
                  <div className="flex items-center gap-2 shrink-0">
                    {active && (
                      <button
                        type="submit"
                        formAction={useSession.bind(null, active.id)}
                        className="text-sm underline text-primary-dark whitespace-nowrap"
                      >
                        扣一堂（不收費）
                      </button>
                    )}
                    <input
                      type="number"
                      name={`qty_${s.id}`}
                      min={0}
                      defaultValue={0}
                      title="另購新的一組（會收費並開新商品券）"
                      className="w-16 border border-primary-light rounded-lg px-2 py-1 text-center"
                    />
                  </div>
                </div>
              );
            })}
            {packageServices.length === 0 && (
              <p className="text-sm text-foreground/50">還沒有商品券方案，可到「服務項目」新增。</p>
            )}
          </div>
          <p className="text-xs text-foreground/40 mt-1">
            右邊數字欄是「另購新的一組」，會收費並開一張新商品券；「扣一堂」不收費，只是使用既有堂數。
          </p>
        </div>

        <button
          type="submit"
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          建立訂單
        </button>
      </form>
    </main>
  );
}
