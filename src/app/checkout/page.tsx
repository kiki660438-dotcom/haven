import { createClient } from "@/lib/supabase-server";
import { createOrder } from "./actions";

export default async function CheckoutPage({
  searchParams,
}: {
  searchParams: Promise<{ appointment?: string }>;
}) {
  const { appointment: appointmentId } = await searchParams;
  const supabase = await createClient();

  const [{ data: customers }, { data: services }] = await Promise.all([
    supabase.from("customers").select("*").order("name"),
    supabase.from("services").select("*").order("name"),
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

  return (
    <main className="max-w-2xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">開單結帳</h1>

      <form
        action={createOrder}
        className="flex flex-col gap-5 p-5 border border-primary-light rounded-xl bg-white"
      >
        {appointment && (
          <input type="hidden" name="appointment_id" value={appointment.id} />
        )}

        <div>
          <label className="block text-sm mb-1 text-foreground/60">選擇客戶</label>
          <select
            name="customer_id"
            defaultValue={appointment?.customer_id ?? ""}
            className="w-full border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
          >
            <option value="">現場客（未選擇）</option>
            {customers?.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}（{c.phone}）
              </option>
            ))}
          </select>
        </div>

        <input
          name="customer_name"
          placeholder="現場客姓名（若上面沒選客戶可填這裡）"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />

        <div>
          <label className="block text-sm mb-2 text-foreground/60">選擇服務項目與數量</label>
          <div className="flex flex-col gap-2">
            {services?.map((s) => (
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
          {services?.length === 0 && (
            <p className="text-sm text-foreground/50 mt-2">
              還沒有服務項目，請先到「服務項目」頁面新增。
            </p>
          )}
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
