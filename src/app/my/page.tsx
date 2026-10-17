import type { Metadata } from "next";
import { cookies } from "next/headers";
import { CalendarDays, Receipt, Scissors, Ticket } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { verifyCustomerToken, CUSTOMER_COOKIE } from "@/lib/customer-identity";
import {
  verifyPhone,
  logoutCustomer,
  getAvailableSlots,
  getClosedDates,
  getMaxAdvanceBookingDate,
} from "../book/actions";
import { cancelMyAppointment, rescheduleMyAppointment } from "./actions";
import TimeSlotOption from "../components/TimeSlotOption";
import SubmitButton from "../components/SubmitButton";
import PendingGetForm from "../components/PendingGetForm";
import DatePicker from "../components/DatePicker";
import { getAdminClient } from "@/lib/supabase-admin";
import { earliestBookingDate } from "@/lib/booking-window";

const statusLabel: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  cancelled: "已取消",
  completed: "已完成",
};

const statusPill: Record<string, string> = {
  pending: "bg-amber-50 text-amber-700",
  confirmed: "bg-emerald-50 text-emerald-700",
  cancelled: "bg-gray-100 text-gray-500",
  completed: "bg-gray-100 text-gray-500",
};

type ServiceItem = { name: string; price: number };
type ServiceRef = ServiceItem | ServiceItem[] | null;

function displayServices(
  services: ServiceRef,
  linked: { services: ServiceRef }[] | null | undefined
): ServiceItem[] {
  if (linked && linked.length > 0) {
    return linked
      .map((row) => (Array.isArray(row.services) ? row.services[0] : row.services))
      .filter((s): s is ServiceItem => !!s);
  }
  const single = Array.isArray(services) ? services[0] : services;
  return single ? [single] : [];
}

function dateParts(iso: string) {
  const d = new Date(iso);
  const fmt = (o: Intl.DateTimeFormatOptions) =>
    new Intl.DateTimeFormat("zh-TW", { timeZone: "Asia/Taipei", ...o }).format(d);
  return {
    month: fmt({ month: "numeric" }),
    day: fmt({ day: "numeric" }),
    weekday: fmt({ weekday: "short" }),
    time: fmt({ hour: "2-digit", minute: "2-digit", hour12: false }),
    full: fmt({ year: "numeric", month: "numeric", day: "numeric" }),
  };
}

const CARD = "bg-white rounded-2xl shadow-sm ring-1 ring-black/5";

export const metadata: Metadata = {
  title: "Haven Hair 會員中心",
  manifest: "/api/manifest?start=my",
  appleWebApp: { capable: true, title: "Haven Hair", statusBarStyle: "default" },
};

export default async function MyPage({
  searchParams,
}: {
  searchParams: Promise<{
    error?: string;
    success?: string;
    reschedule?: string;
    r_date?: string;
    tab?: string;
  }>;
}) {
  const { error, success, reschedule, r_date, tab } = await searchParams;
  const cookieStore = await cookies();
  const identity = verifyCustomerToken(cookieStore.get(CUSTOMER_COOKIE)?.value);

  const lineLoginUrl = `/api/line/login?returnTo=${encodeURIComponent("/my")}`;

  if (!identity) {
    return (
      <main className="max-w-md mx-auto px-5 py-8 min-h-[80vh] bg-[#f6fafc]">
        <div className="rounded-3xl bg-gradient-to-br from-[#5fa8cc] to-[#8ecae6] text-white p-6 mb-5 shadow-md">
          <p className="text-sm opacity-90">Haven Hair 中途髮廊</p>
          <h1 className="text-2xl font-bold mt-1">會員中心</h1>
          <p className="text-sm opacity-90 mt-2">驗證身份後，查看您的預約、商品券與消費紀錄</p>
        </div>

        {error === "no_identity" && (
          <div className="mb-4 p-4 rounded-2xl bg-red-50 text-red-600 text-sm">
            請填寫姓名與電話，或使用 LINE 帳號驗證身份。
          </div>
        )}

        <div className={`${CARD} p-5 flex flex-col gap-4`}>
          <form action={verifyPhone} className="flex flex-col gap-3">
            <input type="hidden" name="return_to" value="/my" />
            <input
              name="name"
              placeholder="姓名"
              required
              className="rounded-xl bg-[#f6fafc] px-4 py-3 outline-none focus:ring-2 focus:ring-primary"
            />
            <input
              name="phone"
              placeholder="手機號碼"
              required
              inputMode="tel"
              className="rounded-xl bg-[#f6fafc] px-4 py-3 outline-none focus:ring-2 focus:ring-primary"
            />
            <SubmitButton
              pendingText="登入中…"
              className="bg-primary-dark text-white rounded-xl px-4 py-3 font-medium hover:bg-primary transition-colors"
            >
              電話登入
            </SubmitButton>
          </form>

          <a href={lineLoginUrl} className="text-center text-sm underline text-primary-dark">
            沒有台灣手機號碼？點此使用 LINE 帳號登入
          </a>
        </div>
      </main>
    );
  }

  // 消費紀錄含金額，不能走公開權限；只在伺服器端用 identity（已驗簽的 cookie）裡的客人 id 查，
  // 沒設定金鑰時就不顯示這一區，其他功能不受影響
  const admin = getAdminClient();
  const ordersPromise = admin
    ? admin
        .from("orders")
        .select("id, total, created_at, order_items(service_name, price, quantity)")
        .eq("customer_id", identity.customerId)
        .eq("status", "paid")
        .order("created_at", { ascending: false })
        .limit(50)
    : Promise.resolve({ data: null });

  const [{ data: appointments }, { data: vouchers }, { data: orders }] = await Promise.all([
    supabase
      .from("appointments")
      .select(
        "id, start_time, status, service_id, staff_id, services(name, price), appointment_services(service_id, services(name, price))"
      )
      .eq("customer_id", identity.customerId)
      .order("start_time", { ascending: false }),
    supabase
      .from("vouchers")
      .select("id, service_name, total_sessions, remaining_sessions, purchased_at, status")
      .eq("customer_id", identity.customerId)
      .order("purchased_at", { ascending: false }),
    ordersPromise,
  ]);

  const now = Date.now();
  const upcoming = (appointments ?? [])
    .filter(
      (a) => a.status !== "cancelled" && a.status !== "completed" && new Date(a.start_time).getTime() >= now
    )
    .sort((a, b) => new Date(a.start_time).getTime() - new Date(b.start_time).getTime());
  const past = (appointments ?? []).filter((a) => !upcoming.includes(a));
  const pastCancelled = past.filter((a) => a.status === "cancelled");
  const pastDone = past.filter((a) => a.status !== "cancelled");
  const activeVouchers = (vouchers ?? []).filter((v) => v.status === "active");
  const inactiveVouchers = (vouchers ?? []).filter((v) => v.status !== "active");

  const hasOrders = orders !== null;
  const tabs = [
    { key: "appointments", label: "預約", icon: CalendarDays },
    { key: "vouchers", label: "商品券", icon: Ticket },
    ...(hasOrders ? [{ key: "orders", label: "消費紀錄", icon: Receipt }] : []),
  ];
  const activeTab = reschedule
    ? "appointments"
    : tabs.some((t) => t.key === tab)
      ? (tab as string)
      : "appointments";

  const reschedulingAppointment = reschedule
    ? upcoming.find((a) => a.id === reschedule)
    : undefined;
  const reschedulingServiceIds = reschedulingAppointment
    ? reschedulingAppointment.appointment_services?.length
      ? reschedulingAppointment.appointment_services.map((row) => row.service_id)
      : [reschedulingAppointment.service_id]
    : [];
  const [rescheduleClosedDates, rescheduleMaxDate] = reschedulingAppointment
    ? await Promise.all([getClosedDates(earliestBookingDate()), getMaxAdvanceBookingDate()])
    : [[], ""];
  const rescheduleSlots =
    reschedulingAppointment && r_date
      ? await getAvailableSlots(
          reschedulingServiceIds,
          r_date,
          reschedulingAppointment.staff_id ?? undefined
        )
      : null;

  return (
    <main className="max-w-md mx-auto bg-[#f6fafc] min-h-[85vh] px-5 pt-5 pb-28">
      {/* 會員卡 */}
      <section className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-[#5fa8cc] to-[#8ecae6] text-white p-6 shadow-md mb-5">
        <div className="absolute -right-10 -top-10 h-40 w-40 rounded-full bg-white/10" />
        <div className="absolute -right-2 top-16 h-24 w-24 rounded-full bg-white/10" />
        <div className="relative flex items-start justify-between gap-3">
          <div>
            <p className="text-xs opacity-80">會員</p>
            <h1 className="text-2xl font-bold mt-0.5">{identity.name}</h1>
          </div>
          <form action={logoutCustomer}>
            <input type="hidden" name="return_to" value="/my" />
            <button
              type="submit"
              className="text-xs rounded-full bg-white/20 px-3 py-1.5 touch-manipulation active:bg-white/30"
            >
              登出
            </button>
          </form>
        </div>
        <div className="relative mt-6 grid grid-cols-3 text-center">
          <div>
            <p className="text-2xl font-semibold">{activeVouchers.length}</p>
            <p className="text-xs opacity-85">可用商品券</p>
          </div>
          <div>
            <p className="text-2xl font-semibold">{upcoming.length}</p>
            <p className="text-xs opacity-85">即將預約</p>
          </div>
          <div>
            <p className="text-2xl font-semibold">
              {hasOrders ? (orders.length >= 50 ? "50+" : orders.length) : "-"}
            </p>
            <p className="text-xs opacity-85">消費次數</p>
          </div>
        </div>
      </section>

      {success === "reschedule" && (
        <div className="mb-4 p-4 rounded-2xl bg-emerald-50 text-emerald-700 text-sm">
          改期成功！新的時段待店家確認。
        </div>
      )}
      {error === "conflict" && (
        <div className="mb-4 p-4 rounded-2xl bg-red-50 text-red-600 text-sm">
          抱歉，這個時段沒有空，請選擇其他時段。
        </div>
      )}
      {error === "no_slot" && (
        <div className="mb-4 p-4 rounded-2xl bg-red-50 text-red-600 text-sm">請選擇一個時段。</div>
      )}

      {/* 預約 */}
      {activeTab === "appointments" && (
        <section>
          <h2 className="text-base font-semibold mb-3 px-1">即將到來的預約</h2>
          <div className="flex flex-col gap-3 mb-7">
            {upcoming.map((a) => {
              const services = displayServices(a.services, a.appointment_services);
              const p = dateParts(a.start_time);
              const isRescheduling = reschedule === a.id;
              return (
                <div key={a.id} className={`${CARD} p-4`}>
                  <div className="flex gap-4">
                    <div className="shrink-0 w-14 rounded-xl bg-primary-light text-primary-dark text-center py-2">
                      <p className="text-[11px] leading-none">{p.month}月</p>
                      <p className="text-2xl font-bold leading-tight">{p.day}</p>
                      <p className="text-[11px] leading-none">{p.weekday}</p>
                    </div>
                    <div className="min-w-0 flex-1">
                      <div className="flex items-center justify-between gap-2">
                        <p className="text-lg font-semibold">{p.time}</p>
                        <span
                          className={`text-xs px-2.5 py-1 rounded-full ${statusPill[a.status] ?? "bg-gray-100 text-gray-500"}`}
                        >
                          {statusLabel[a.status] ?? a.status}
                        </span>
                      </div>
                      <p className="text-sm text-foreground/70 mt-1 break-words">
                        {services.map((s) => s.name).join("、")}
                      </p>
                    </div>
                  </div>

                  <div className="flex gap-2 mt-4">
                    <a
                      href={isRescheduling ? "/my" : `/my?reschedule=${a.id}`}
                      className="flex-1 text-center text-sm rounded-xl bg-primary-light text-primary-dark py-2.5 touch-manipulation active:opacity-80"
                    >
                      {isRescheduling ? "取消改期" : "改期"}
                    </a>
                    <form action={cancelMyAppointment.bind(null, a.id)} className="flex-1">
                      <SubmitButton
                        pendingText="取消中…"
                        className="w-full text-sm rounded-xl bg-red-50 text-red-500 py-2.5"
                      >
                        取消預約
                      </SubmitButton>
                    </form>
                  </div>

                  {isRescheduling && (
                    <div className="mt-4 pt-4 border-t border-black/5 flex flex-col gap-3">
                      <PendingGetForm
                        action="/my"
                        label="查詢時段"
                        pendingLabel="查詢中…"
                        className="flex flex-col gap-2"
                      >
                        <input type="hidden" name="reschedule" value={a.id} />
                        <DatePicker
                          name="r_date"
                          min={earliestBookingDate()}
                          max={rescheduleMaxDate}
                          closed={rescheduleClosedDates}
                          defaultValue={r_date}
                        />
                      </PendingGetForm>

                      {rescheduleSlots && (
                        <form
                          action={rescheduleMyAppointment.bind(null, a.id)}
                          className="flex flex-col gap-3"
                        >
                          <input type="hidden" name="date" value={r_date} />
                          {rescheduleSlots.length > 0 ? (
                            <div className="grid grid-cols-4 gap-2">
                              {rescheduleSlots.map((t) => (
                                <TimeSlotOption key={t} time={t} />
                              ))}
                            </div>
                          ) : (
                            <p className="text-sm text-foreground/50">這天沒有空的時段，請選擇其他日期。</p>
                          )}
                          {rescheduleSlots.length > 0 && (
                            <SubmitButton pendingText="改期中…">確認改期</SubmitButton>
                          )}
                        </form>
                      )}
                    </div>
                  )}
                </div>
              );
            })}
            {upcoming.length === 0 && (
              <div className={`${CARD} p-6 text-center text-sm text-foreground/50`}>
                目前沒有即將到來的預約
              </div>
            )}
          </div>

          <h2 className="text-base font-semibold mb-3 px-1">歷史預約</h2>
          <div className="flex flex-col gap-2">
            {pastDone.map((a) => {
              const services = displayServices(a.services, a.appointment_services);
              const p = dateParts(a.start_time);
              return (
                <div
                  key={a.id}
                  className={`${CARD} px-4 py-3 text-sm flex items-center justify-between gap-3`}
                >
                  <span className="text-foreground/70 min-w-0 break-words">
                    {services.map((s) => s.name).join("、")}
                  </span>
                  <span className="text-foreground/50 whitespace-nowrap text-xs">{p.full}</span>
                </div>
              );
            })}
            {pastDone.length === 0 && (
              <div className={`${CARD} p-5 text-center text-sm text-foreground/50`}>
                還沒有歷史預約紀錄
              </div>
            )}
            {pastCancelled.length > 0 && (
              <details className="mt-2">
                <summary className="text-xs text-foreground/50 cursor-pointer select-none px-1 py-1">
                  已取消的預約（{pastCancelled.length}）
                </summary>
                <div className="flex flex-col gap-2 mt-2">
                  {pastCancelled.map((a) => {
                    const services = displayServices(a.services, a.appointment_services);
                    const p = dateParts(a.start_time);
                    return (
                      <div
                        key={a.id}
                        className="rounded-xl bg-white/60 px-4 py-2.5 text-xs text-foreground/50 flex items-center justify-between gap-3"
                      >
                        <span className="min-w-0 break-words line-through">
                          {services.map((s) => s.name).join("、")}
                        </span>
                        <span className="whitespace-nowrap">{p.full}</span>
                      </div>
                    );
                  })}
                </div>
              </details>
            )}
          </div>
        </section>
      )}

      {/* 商品券 */}
      {activeTab === "vouchers" && (
        <section>
          <h2 className="text-base font-semibold mb-3 px-1">我的商品券</h2>
          <div className="flex flex-col gap-3 mb-6">
            {activeVouchers.map((v) => {
              const pct = v.total_sessions
                ? Math.max(0, Math.min(100, (v.remaining_sessions / v.total_sessions) * 100))
                : 0;
              return (
                <div key={v.id} className={`${CARD} p-4 relative overflow-hidden`}>
                  <div className="absolute left-0 top-0 bottom-0 w-1.5 bg-primary-dark" />
                  <p className="font-semibold pl-2">{v.service_name}</p>
                  <div className="flex items-baseline justify-between mt-3 pl-2">
                    <p className="text-primary-dark">
                      剩餘 <span className="text-3xl font-bold">{v.remaining_sessions}</span>
                      <span className="text-sm"> / {v.total_sessions} 堂</span>
                    </p>
                    {v.purchased_at && (
                      <p className="text-xs text-foreground/40">購買 {v.purchased_at}</p>
                    )}
                  </div>
                  <div className="mt-3 ml-2 h-2 rounded-full bg-primary-light overflow-hidden">
                    <div className="h-full rounded-full bg-primary-dark" style={{ width: `${pct}%` }} />
                  </div>
                </div>
              );
            })}
            {activeVouchers.length === 0 && (
              <div className={`${CARD} p-6 text-center text-sm text-foreground/50`}>
                目前沒有可使用的商品券
              </div>
            )}
          </div>

          {inactiveVouchers.length > 0 && (
            <details>
              <summary className="text-sm font-semibold cursor-pointer select-none px-1 py-1">
                已用完／已過期（{inactiveVouchers.length}）
              </summary>
              <div className="flex flex-col gap-2 mt-3">
                {inactiveVouchers.map((v) => (
                  <div
                    key={v.id}
                    className="rounded-xl bg-white/60 px-4 py-3 text-sm text-foreground/60 flex items-center justify-between gap-3"
                  >
                    <div className="min-w-0">
                      <p className="break-words">{v.service_name}</p>
                      {v.purchased_at && (
                        <p className="text-xs text-foreground/40">購買 {v.purchased_at}</p>
                      )}
                    </div>
                    <span className="whitespace-nowrap text-xs">
                      {v.status === "expired" ? "已過期" : "已用完"}・共 {v.total_sessions} 堂
                    </span>
                  </div>
                ))}
              </div>
            </details>
          )}
        </section>
      )}

      {/* 消費紀錄 */}
      {activeTab === "orders" && orders && (
        <section>
          <h2 className="text-base font-semibold mb-3 px-1">消費紀錄</h2>
          <div className="flex flex-col gap-3">
            {orders.map((o) => (
              <div key={o.id} className={`${CARD} p-4`}>
                <div className="flex items-center justify-between gap-3">
                  <span className="text-xs text-foreground/50">{dateParts(o.created_at).full}</span>
                  <span className="font-semibold text-primary-dark">
                    {o.total > 0 ? `實付 $${o.total.toLocaleString()}` : "商品券扣堂／贈送"}
                  </span>
                </div>
                <p className="text-sm text-foreground/75 mt-2 break-words">
                  {(o.order_items ?? [])
                    .map((it) => (it.quantity > 1 ? `${it.service_name} x${it.quantity}` : it.service_name))
                    .join("、")}
                </p>
              </div>
            ))}
            {orders.length === 0 && (
              <div className={`${CARD} p-6 text-center text-sm text-foreground/50`}>
                還沒有消費紀錄
              </div>
            )}
          </div>
        </section>
      )}

      {/* 底部分頁列 */}
      <nav className="fixed bottom-0 inset-x-0 z-10 bg-white/95 backdrop-blur border-t border-black/5">
        <div className="max-w-md mx-auto flex items-stretch justify-around px-2 pb-[env(safe-area-inset-bottom)]">
          {tabs.map((t) => {
            const Icon = t.icon;
            const on = activeTab === t.key;
            return (
              <a
                key={t.key}
                href={`/my?tab=${t.key}`}
                className={`flex-1 flex flex-col items-center gap-1 py-2.5 text-[11px] touch-manipulation ${
                  on ? "text-primary-dark font-semibold" : "text-foreground/45"
                }`}
              >
                <Icon size={22} strokeWidth={on ? 2.4 : 1.8} />
                {t.label}
              </a>
            );
          })}
          <a
            href="/book"
            className="flex-1 flex flex-col items-center gap-1 py-2.5 text-[11px] text-foreground/45 touch-manipulation"
          >
            <Scissors size={22} strokeWidth={1.8} />
            我要預約
          </a>
        </div>
      </nav>
    </main>
  );
}
