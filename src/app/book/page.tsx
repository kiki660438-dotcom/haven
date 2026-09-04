import { cookies } from "next/headers";
import { supabase } from "@/lib/supabase";
import { verifyCustomerToken, CUSTOMER_COOKIE } from "@/lib/customer-identity";
import { createBooking, getAvailableSlots, verifyPhone, logoutCustomer } from "./actions";
import { ChevronDown } from "lucide-react";

function buildQuery(serviceIds: string[], date: string, staffId?: string) {
  const params = new URLSearchParams();
  for (const id of serviceIds) params.append("service_id", id);
  params.set("date", date ?? "");
  params.set("staff_id", staffId ?? "");
  return params.toString();
}

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

export default async function BookPage({
  searchParams,
}: {
  searchParams: Promise<{
    success?: string;
    error?: string;
    service_id?: string | string[];
    date?: string;
    staff_id?: string;
  }>;
}) {
  const { success, error, service_id, date, staff_id } = await searchParams;
  const serviceIds = service_id ? (Array.isArray(service_id) ? service_id : [service_id]) : [];

  const [{ data: allServices }, { data: staffList }] = await Promise.all([
    supabase.from("services").select("*").order("name"),
    supabase.from("staff").select("id, name").eq("active", true).order("name"),
  ]);

  // 商品券方案（有堂數的服務）只在店內結帳銷售，加上被標記「不開放線上預約」的項目，線上預約選單都不顯示
  const services = allServices?.filter((s) => !s.total_sessions && !s.hide_from_booking);
  const serviceGroups = groupServices(services ?? []);

  const slots =
    serviceIds.length > 0 && date ? await getAvailableSlots(serviceIds, date, staff_id) : null;

  const cookieStore = await cookies();
  const identity = verifyCustomerToken(cookieStore.get(CUSTOMER_COOKIE)?.value);

  const returnTo = `/book?${buildQuery(serviceIds, date ?? "", staff_id)}`;
  const lineLoginUrl = `/api/line/login?returnTo=${encodeURIComponent(returnTo)}`;

  return (
    <main className="max-w-xl mx-auto p-8">
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold text-primary-dark">線上預約</h1>
        <a href="/my" className="text-sm underline text-primary-dark">
          查看我的預約／商品券
        </a>
      </div>

      {success && (
        <div className="mb-6 p-4 rounded-xl bg-primary-light text-primary-dark">
          預約已送出！我們會盡快與您確認 🎉
        </div>
      )}
      {error === "conflict" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          抱歉，這個時段剛剛被其他客人預約走了，請重新選擇時段。
        </div>
      )}
      {error === "no_slot" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          請至少選擇一項服務，並選一個可預約時段。
        </div>
      )}
      {error === "no_identity" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          請填寫姓名與電話，或使用 LINE 帳號驗證身份。
        </div>
      )}
      {error === "line_login" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          LINE 登入失敗，請再試一次。
        </div>
      )}

      <form
        method="GET"
        action="/book"
        className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white mb-6"
      >
        <div>
          <p className="text-sm mb-2 text-foreground/60">選擇服務 *（可複選）</p>
          <div className="flex flex-col gap-1 max-h-80 overflow-y-auto border border-primary-light rounded-lg p-2">
            {serviceGroups.map((g) => {
              if (g.items.length === 1) {
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
              }
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

      {slots && !identity && (
        <div className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white">
          <p className="text-sm text-foreground/60">
            第一次預約請先驗證身份，之後系統會記住您，不用再輸入姓名電話。
          </p>

          <form action={verifyPhone} className="flex flex-col gap-3">
            {serviceIds.map((id) => (
              <input key={id} type="hidden" name="service_id" value={id} />
            ))}
            <input type="hidden" name="date" value={date} />
            <input type="hidden" name="return_to" value={returnTo} />
            <input
              name="name"
              placeholder="姓名 *"
              required
              className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
            />
            <input
              name="phone"
              placeholder="電話 *"
              required
              className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
            />
            <div className="flex gap-3">
              <label className="flex-1 flex flex-col gap-1 text-sm text-foreground/60">
                生日年月日（選填）
                <input
                  name="birthday"
                  type="date"
                  className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
                />
              </label>
              <label className="flex-1 flex flex-col gap-1 text-sm text-foreground/60">
                性別（選填）
                <select
                  name="gender"
                  defaultValue=""
                  className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
                >
                  <option value=""></option>
                  <option value="male">男</option>
                  <option value="female">女</option>
                  <option value="other">不透露</option>
                </select>
              </label>
            </div>
            <button
              type="submit"
              className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
            >
              電話登入
            </button>
          </form>

          <a
            href={lineLoginUrl}
            className="text-center text-sm underline text-primary-dark"
          >
            沒有台灣手機號碼？點此使用 LINE 帳號登入
          </a>
        </div>
      )}

      {slots && identity && (
        <div className="flex items-center justify-between p-3 mb-4 rounded-lg bg-primary-light text-primary-dark text-sm">
          <span>哈囉，{identity.name}！</span>
          <form action={logoutCustomer}>
            {serviceIds.map((id) => (
              <input key={id} type="hidden" name="service_id" value={id} />
            ))}
            <input type="hidden" name="date" value={date} />
            <input type="hidden" name="return_to" value={returnTo} />
            <button type="submit" className="underline">
              不是您本人？登出
            </button>
          </form>
        </div>
      )}

      {slots && identity && (
        <form
          action={createBooking}
          className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white"
        >
          {serviceIds.map((id) => (
            <input key={id} type="hidden" name="service_id" value={id} />
          ))}
          <input type="hidden" name="date" value={date} />
          <input type="hidden" name="staff_id" value={staff_id ?? ""} />
          <input type="hidden" name="customer_id" value={identity.customerId} />

          {slots.length > 0 ? (
            <div>
              <p className="text-sm text-foreground/60 mb-2">選擇可預約時段 *</p>
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
              送出預約
            </button>
          )}
        </form>
      )}
    </main>
  );
}
