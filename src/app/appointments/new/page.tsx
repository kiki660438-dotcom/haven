import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { createStaffAppointment } from "./actions";
import { getAvailableSlots } from "../../book/actions";
import CustomerPicker from "../../checkout/CustomerPicker";
import { ChevronDown } from "lucide-react";

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
  }>;
}) {
  const { error, service_id, date, staff_id } = await searchParams;
  const serviceIds = service_id ? (Array.isArray(service_id) ? service_id : [service_id]) : [];

  const supabase = await createClient();
  const [{ data: allServices }, { data: staffList }, { data: customers }] = await Promise.all([
    supabase.from("services").select("id, name, price, total_sessions").order("name"),
    supabase.from("staff").select("id, name").eq("active", true).order("name"),
    supabase.from("customers").select("id, name, phone").order("name"),
  ]);

  const services = (allServices ?? []).filter((s) => !s.total_sessions);
  const serviceGroups = groupServices(services);
  const singleServiceGroups = serviceGroups.filter((g) => g.items.length === 1);
  const multiServiceGroups = serviceGroups.filter((g) => g.items.length > 1);

  const slots =
    serviceIds.length > 0 && date ? await getAvailableSlots(serviceIds, date, staff_id) : null;

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
        className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white mb-6"
      >
        <div>
          <p className="text-sm mb-2 text-foreground/60">選擇服務 *（可複選）</p>
          <div className="flex flex-col gap-1 max-h-80 overflow-y-auto border border-primary-light rounded-lg p-2">
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
            <CustomerPicker customers={customers ?? []} name="customer_id" />
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
              <p className="text-sm text-foreground/60 mb-2">選擇時段 *</p>
              <div className="grid grid-cols-4 gap-2">
                {slots.map((t) => (
                  <label
                    key={t}
                    className="flex items-center justify-center gap-1 border border-primary-light rounded-lg px-2 py-2 text-sm cursor-pointer has-[:checked]:bg-primary-dark has-[:checked]:text-white"
                  >
                    <input type="radio" name="time" value={t} required className="hidden" />
                    {t}
                  </label>
                ))}
              </div>
            </div>
          ) : (
            <p className="text-sm text-foreground/50">
              這天已經沒有空的時段了，請選擇其他日期。
            </p>
          )}

          {slots.length > 0 && (
            <button
              type="submit"
              className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
            >
              建立預約
            </button>
          )}
        </form>
      )}
    </main>
  );
}
