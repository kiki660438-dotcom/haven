import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { createStaffAppointment } from "./actions";
import { getStaffSlots } from "../../book/actions";
import CustomerPicker from "../../checkout/CustomerPicker";
import { ChevronDown } from "lucide-react";
import TimeSlotOption from "../../components/TimeSlotOption";
import SubmitButton from "../../components/SubmitButton";

type ServiceOption = { id: string; name: string; price: number };

// 服務名稱用「主題-細項」命名（例如「冷塑燙-中髮」），依主題分組；
// 只有一種選項的（例如「剪髮」）不用分組，直接顯示
function groupServices(services: ServiceOption[]) {
  const map = new Map<string, ServiceOption[]>();
  for (const s of services) {
    const dashIndex = s.name.indexOf("-");
    const title = dashIndex === -1 ? s.name : s.name.slice(0, dashIndex);
    if (!map.has(title)) map.set(title, []);
    map.get(title)!.push(s);
  }
  return [...map.entries()].map(([title, items]) => ({ title, items }));
}

export default async function NewAppointmentPage({
  searchParams,
}: {
  searchParams: Promise<{
    error?: string;
    service_id?: string | string[];
    date?: string;
    staff_id?: string;
    customer_id?: string;
  }>;
}) {
  const { error, service_id, date, staff_id, customer_id } = await searchParams;
  const customerId = customer_id ?? "";
  const serviceIds = service_id ? (Array.isArray(service_id) ? service_id : [service_id]) : [];

  const supabase = await createClient();
  const [{ data: allServices }, { data: staffList }, { data: customers }, { data: voucherRows }] =
    await Promise.all([
      supabase.from("services").select("id, name, price, total_sessions").order("name"),
      supabase.from("staff").select("id, name").eq("active", true).order("name"),
      supabase.from("customers").select("id, name, phone").order("name"),
      customerId
        ? supabase
            .from("vouchers")
            .select("service_name, remaining_sessions")
            .eq("customer_id", customerId)
            .eq("status", "active")
            .gt("remaining_sessions", 0)
        : Promise.resolve({ data: [] as { service_name: string | null; remaining_sessions: number }[] }),
    ]);

  const selectedCustomer = customers?.find((c) => c.id === customerId);
  const customerLabel = selectedCustomer
    ? `${selectedCustomer.name}（${selectedCustomer.phone ?? ""}）`
    : undefined;

  // 客人已購買的商品券：同一種方案有多張時合併堂數，點選後預約的是該方案本身（開單時再「扣一堂」）
  const packageByName = new Map((allServices ?? []).filter((s) => s.total_sessions).map((s) => [s.name, s]));
  const voucherOptions = new Map<string, { id: string; name: string; remaining: number }>();
  for (const v of voucherRows ?? []) {
    const pkg = v.service_name ? packageByName.get(v.service_name) : undefined;
    if (!pkg) continue;
    const existing = voucherOptions.get(pkg.id);
    voucherOptions.set(pkg.id, {
      id: pkg.id,
      name: pkg.name,
      remaining: (existing?.remaining ?? 0) + v.remaining_sessions,
    });
  }
  const vouchers = [...voucherOptions.values()];

  const services = (allServices ?? []).filter((s) => !s.total_sessions);
  const serviceGroups = groupServices(services);
  const singleServiceGroups = serviceGroups.filter((g) => g.items.length === 1);
  const multiServiceGroups = serviceGroups.filter((g) => g.items.length > 1);

  const slots =
    serviceIds.length > 0 && date ? await getStaffSlots(serviceIds, date, staff_id) : null;

  return (
    <main className="max-w-xl mx-auto p-8">
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold text-primary-dark">新增預約（後台代客預約）</h1>
        <Link href="/appointments" className="text-sm underline text-primary-dark">
          回預約管理
        </Link>
      </div>

      {error === "conflict" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          這個時段沒有空，請重新選擇。
        </div>
      )}
      {error === "no_slot" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          請選擇服務、日期與時段。
        </div>
      )}
      {error === "no_customer" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          請選擇現有客人，或填寫新客人姓名與電話。
        </div>
      )}

      <form
        method="GET"
        action="/appointments/new"
        className="flex flex-col gap-3 p-5 border border-primary-light rounded-xl bg-white mb-6"
      >
        <p className="text-sm text-foreground/60">
          先選客人，系統會自動列出他已購買的商品券。新客人或現場客可以略過這一步。
        </p>
        <CustomerPicker
          customers={customers ?? []}
          name="customer_id"
          defaultCustomerId={customerId}
          defaultLabel={customerLabel}
        />
        <button
          type="submit"
          className="bg-primary-light text-primary-dark rounded-lg px-4 py-2 hover:bg-primary/30 transition-colors"
        >
          選擇客人
        </button>
      </form>

      <form
        method="GET"
        action="/appointments/new"
        className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white mb-6"
      >
        <input type="hidden" name="customer_id" value={customerId} />
        <div>
          <p className="text-sm mb-2 text-foreground/60">選擇服務 *（可複選）</p>
          <div className="flex flex-col gap-1 max-h-80 overflow-y-auto border border-primary-light rounded-lg p-2">
            {customerId && (
              <div className="mb-1">
                <p className="text-xs text-foreground/50 px-2 py-1">
                  {selectedCustomer?.name} 已購買的商品券（預約後開單再扣堂）
                </p>
                {vouchers.length === 0 && (
                  <p className="text-xs text-foreground/40 px-2 pb-1">目前沒有可用的商品券</p>
                )}
                {vouchers.map((v) => (
                  <label
                    key={v.id}
                    className="flex items-center gap-2 px-2 py-1.5 rounded-lg text-sm cursor-pointer bg-primary-light/50 hover:bg-primary-light mb-1"
                  >
                    <input
                      type="checkbox"
                      name="service_id"
                      value={v.id}
                      defaultChecked={serviceIds.includes(v.id)}
                    />
                    {v.name}（剩 {v.remaining} 次）
                  </label>
                ))}
                <hr className="border-primary-light my-1" />
              </div>
            )}
            {singleServiceGroups.map((g) => {
              const s = g.items[0];
              return (
                <label
                  key={s.id}
                  className="flex items-center gap-2 px-2 py-1.5 rounded-lg text-sm cursor-pointer hover:bg-primary-light"
                >
                  <input
                    type="checkbox"
                    name="service_id"
                    value={s.id}
                    defaultChecked={serviceIds.includes(s.id)}
                  />
                  {s.name}（${s.price}）
                </label>
              );
            })}

            {singleServiceGroups.length > 0 && multiServiceGroups.length > 0 && (
              <hr className="border-primary-light my-1" />
            )}

            {multiServiceGroups.map((g) => {
              const hasChecked = g.items.some((s) => serviceIds.includes(s.id));
              return (
                <details key={g.title} open={hasChecked} className="group">
                  <summary className="flex items-center justify-between gap-2 px-2 py-1.5 rounded-lg text-sm cursor-pointer select-none hover:bg-primary-light">
                    {g.title}
                    <ChevronDown
                      size={14}
                      className="text-foreground/40 transition-transform group-open:rotate-180"
                    />
                  </summary>
                  <div className="flex flex-col gap-1 pl-4 mt-1">
                    {g.items.map((s) => (
                      <label
                        key={s.id}
                        className="flex items-center gap-2 px-2 py-1.5 rounded-lg text-sm cursor-pointer hover:bg-primary-light"
                      >
                        <input
                          type="checkbox"
                          name="service_id"
                          value={s.id}
                          defaultChecked={serviceIds.includes(s.id)}
                        />
                        {s.name.slice(g.title.length + 1)}（${s.price}）
                      </label>
                    ))}
                  </div>
                </details>
              );
            })}
          </div>
        </div>
        <input
          name="date"
          type="date"
          required
          defaultValue={date ?? ""}
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <select
          name="staff_id"
          defaultValue={staff_id ?? ""}
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        >
          <option value="">指定設計師（選填，不指定則自動安排）</option>
          {staffList?.map((s) => (
            <option key={s.id} value={s.id}>
              {s.name}
            </option>
          ))}
        </select>
        <button
          type="submit"
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          查詢可預約時段
        </button>
      </form>

      {slots && (
        <form
          action={createStaffAppointment}
          className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white"
        >
          {serviceIds.map((id) => (
            <input key={id} type="hidden" name="service_id" value={id} />
          ))}
          <input type="hidden" name="date" value={date} />
          <input type="hidden" name="staff_id" value={staff_id ?? ""} />

          <div>
            <p className="text-sm mb-2 text-foreground/60">客人</p>
            <CustomerPicker
              customers={customers ?? []}
              name="customer_id"
              defaultCustomerId={customerId}
              defaultLabel={customerLabel}
            />
            <p className="text-xs text-foreground/50 mt-2 mb-1">如果上面沒選到人，請填新客人資料：</p>
            <div className="grid grid-cols-2 gap-2">
              <input
                name="new_customer_name"
                placeholder="新客人姓名"
                className="border border-primary-light rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-primary"
              />
              <input
                name="new_customer_phone"
                placeholder="新客人電話"
                className="border border-primary-light rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-primary"
              />
            </div>
          </div>

          {slots.length > 0 ? (
            <div>
              <p className="text-sm text-foreground/60 mb-2">
                選擇時段 *（橘框是已經有其他預約的時段，評估可以同時服務的話還是能選）
              </p>
              <div className="grid grid-cols-4 gap-2">
                {slots.map((s) => (
                  <TimeSlotOption key={s.time} time={s.time} busy={s.busy} />
                ))}
              </div>
            </div>
          ) : (
            <p className="text-sm text-foreground/50">
              請至少選擇一項服務。
            </p>
          )}

          {slots.length > 0 && (
            <div>
              <p className="text-sm mb-1 text-foreground/60">
                緩衝時間（選填，服務結束後這段時間內不開放其他人預約）
              </p>
              <div className="flex items-center gap-2">
                <input
                  type="number"
                  name="buffer_hours"
                  min={0}
                  defaultValue={0}
                  className="w-16 border border-primary-light rounded-lg px-2 py-1 text-sm"
                />
                <span className="text-sm text-foreground/50">時</span>
                <input
                  type="number"
                  name="buffer_minutes"
                  min={0}
                  max={59}
                  defaultValue={0}
                  className="w-16 border border-primary-light rounded-lg px-2 py-1 text-sm"
                />
                <span className="text-sm text-foreground/50">分</span>
              </div>
            </div>
          )}

          {slots.length > 0 && (
            <label className="flex flex-col gap-1 text-sm text-foreground/60">
              備註（選填）
              <textarea
                name="note"
                rows={3}
                placeholder="客人需求、想記住的事項都可以寫在這裡"
                className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
              />
            </label>
          )}

          {slots.length > 0 && <SubmitButton pendingText="建立中…">建立預約</SubmitButton>}
        </form>
      )}
    </main>
  );
}
