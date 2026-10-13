import { cookies } from "next/headers";
import { supabase } from "@/lib/supabase";
import { verifyCustomerToken, CUSTOMER_COOKIE } from "@/lib/customer-identity";
import { verifyPhone, logoutCustomer, getAvailableSlots } from "../book/actions";
import { cancelMyAppointment, rescheduleMyAppointment } from "./actions";
import TimeSlotOption from "../components/TimeSlotOption";
import SubmitButton from "../components/SubmitButton";
import { getAdminClient } from "@/lib/supabase-admin";

const statusLabel: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  cancelled: "已取消",
  completed: "已完成",
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

export default async function MyPage({
  searchParams,
}: {
  searchParams: Promise<{
    error?: string;
    success?: string;
    reschedule?: string;
    r_date?: string;
  }>;
}) {
  const { error, success, reschedule, r_date } = await searchParams;
  const cookieStore = await cookies();
  const identity = verifyCustomerToken(cookieStore.get(CUSTOMER_COOKIE)?.value);

  const lineLoginUrl = `/api/line/login?returnTo=${encodeURIComponent("/my")}`;

  if (!identity) {
    return (
      <main className="max-w-xl mx-auto p-8">
        <h1 className="text-2xl font-bold text-primary-dark mb-6">我的預約與商品券</h1>

        {error === "no_identity" && (
          <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
            請填寫姓名與電話，或使用 LINE 帳號驗證身份。
          </div>
        )}

        <div className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white">
          <p className="text-sm text-foreground/60">請先驗證身份查看您的預約與商品券。</p>

          <form action={verifyPhone} className="flex flex-col gap-3">
            <input type="hidden" name="return_to" value="/my" />
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
            <SubmitButton pendingText="登入中…">電話登入</SubmitButton>
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
  const upcoming = (appointments ?? []).filter(
    (a) => a.status !== "cancelled" && a.status !== "completed" && new Date(a.start_time).getTime() >= now
  );
  const past = (appointments ?? []).filter((a) => !upcoming.includes(a));
  const activeVouchers = (vouchers ?? []).filter((v) => v.status === "active");
  const inactiveVouchers = (vouchers ?? []).filter((v) => v.status !== "active");

  const reschedulingAppointment = reschedule
    ? upcoming.find((a) => a.id === reschedule)
    : undefined;
  const reschedulingServiceIds = reschedulingAppointment
    ? reschedulingAppointment.appointment_services?.length
      ? reschedulingAppointment.appointment_services.map((row) => row.service_id)
      : [reschedulingAppointment.service_id]
    : [];
  const rescheduleSlots =
    reschedulingAppointment && r_date
      ? await getAvailableSlots(
          reschedulingServiceIds,
          r_date,
          reschedulingAppointment.staff_id ?? undefined
        )
      : null;

  return (
    <main className="max-w-xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">我的預約與商品券</h1>

      <div className="flex items-center justify-between p-3 mb-6 rounded-lg bg-primary-light text-primary-dark text-sm">
        <span>哈囉，{identity.name}！</span>
        <form action={logoutCustomer}>
          <input type="hidden" name="return_to" value="/my" />
          <button type="submit" className="underline">
            不是您本人？登出
          </button>
        </form>
      </div>

      {success === "reschedule" && (
        <div className="mb-6 p-4 rounded-xl bg-primary-light text-primary-dark">
          改期成功！新的時段待店家確認。
        </div>
      )}
      {error === "conflict" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          抱歉，這個時段沒有空，請選擇其他時段。
        </div>
      )}
      {error === "no_slot" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">請選擇一個時段。</div>
      )}

      <h2 className="font-semibold mb-3">即將到來的預約</h2>
      <div className="flex flex-col gap-2 mb-6">
        {upcoming.map((a) => {
          const services = displayServices(a.services, a.appointment_services);
          const isRescheduling = reschedule === a.id;
          return (
            <div key={a.id} className="p-4 border border-primary-light rounded-xl bg-white">
              <div className="flex items-center justify-between gap-3">
                <div>
                  <p className="font-medium">{services.map((s) => s.name).join("、")}</p>
                  <p className="text-sm text-foreground/60">
                    {new Date(a.start_time).toLocaleString("zh-TW", { timeZone: "Asia/Taipei" })}
                    {" ・ "}
                    {statusLabel[a.status] ?? a.status}
                  </p>
                </div>
                <div className="flex gap-3 shrink-0">
                  <a
                    href={isRescheduling ? "/my" : `/my?reschedule=${a.id}`}
                    className="text-sm underline text-primary-dark whitespace-nowrap"
                  >
                    {isRescheduling ? "取消改期" : "改期"}
                  </a>
                  <form action={cancelMyAppointment.bind(null, a.id)}>
                    <SubmitButton
                      pendingText="取消中…"
                      className="text-red-500 text-sm whitespace-nowrap"
                    >
                      取消預約
                    </SubmitButton>
                  </form>
                </div>
              </div>

              {isRescheduling && (
                <div className="mt-4 pt-4 border-t border-primary-light flex flex-col gap-3">
                  <form method="GET" action="/my" className="flex gap-2">
                    <input type="hidden" name="reschedule" value={a.id} />
                    <input
                      name="r_date"
                      type="date"
                      required
                      defaultValue={r_date ?? ""}
                      className="flex-1 border border-primary-light rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-primary"
                    />
                    <button
                      type="submit"
                      className="bg-primary-dark text-white rounded-lg px-3 py-2 text-sm hover:bg-primary transition-colors"
                    >
                      查詢時段
                    </button>
                  </form>

                  {rescheduleSlots && (
                    <form action={rescheduleMyAppointment.bind(null, a.id)} className="flex flex-col gap-3">
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
          <p className="text-sm text-foreground/50">目前沒有即將到來的預約</p>
        )}
      </div>

      <h2 className="font-semibold mb-3">我的商品券</h2>
      <div className="flex flex-col gap-2 mb-6">
        {activeVouchers.map((v) => (
          <div key={v.id} className="p-4 border border-primary-light rounded-xl bg-white">
            <p className="font-medium">{v.service_name}</p>
            <p className="text-sm text-primary-dark">
              剩餘 {v.remaining_sessions} / {v.total_sessions} 堂
            </p>
            {v.purchased_at && (
              <p className="text-xs text-foreground/50 mt-1">購買日期 {v.purchased_at}</p>
            )}
          </div>
        ))}
        {activeVouchers.length === 0 && (
          <p className="text-sm text-foreground/50">目前沒有可使用的商品券</p>
        )}
      </div>

      {inactiveVouchers.length > 0 && (
        <details className="mb-6">
          <summary className="font-semibold mb-3 cursor-pointer select-none">
            已用完／已過期的商品券（{inactiveVouchers.length}）
          </summary>
          <div className="flex flex-col gap-2 mt-3">
            {inactiveVouchers.map((v) => (
              <div
                key={v.id}
                className="p-3 border border-primary-light rounded-xl bg-white text-sm text-foreground/70 flex items-center justify-between gap-3"
              >
                <div>
                  <p>{v.service_name}</p>
                  {v.purchased_at && (
                    <p className="text-xs text-foreground/50">購買日期 {v.purchased_at}</p>
                  )}
                </div>
                <span className="whitespace-nowrap">
                  {v.status === "expired" ? "已過期" : "已用完"}（共 {v.total_sessions} 堂）
                </span>
              </div>
            ))}
          </div>
        </details>
      )}

      {orders && (
        <>
          <h2 className="font-semibold mb-3">消費紀錄</h2>
          <div className="flex flex-col gap-2 mb-6">
            {orders.map((o) => (
              <div key={o.id} className="p-3 border border-primary-light rounded-xl bg-white text-sm">
                <div className="flex items-center justify-between gap-3">
                  <span className="text-foreground/60">
                    {new Date(o.created_at).toLocaleDateString("zh-TW", { timeZone: "Asia/Taipei" })}
                  </span>
                  <span className="font-medium">
                    {o.total > 0 ? `實付 $${o.total}` : "商品券扣堂／贈送"}
                  </span>
                </div>
                <p className="text-foreground/70 mt-1">
                  {(o.order_items ?? [])
                    .map((it) => (it.quantity > 1 ? `${it.service_name} x${it.quantity}` : it.service_name))
                    .join("、")}
                </p>
              </div>
            ))}
            {orders.length === 0 && <p className="text-sm text-foreground/50">還沒有消費紀錄</p>}
          </div>
        </>
      )}

      <h2 className="font-semibold mb-3">歷史預約</h2>
      <div className="flex flex-col gap-2">
        {past.map((a) => {
          const services = displayServices(a.services, a.appointment_services);
          return (
            <div
              key={a.id}
              className="p-3 border border-primary-light rounded-xl bg-white text-sm text-foreground/70 flex items-center justify-between"
            >
              <span>{services.map((s) => s.name).join("、")}</span>
              <span>
                {new Date(a.start_time).toLocaleDateString("zh-TW", { timeZone: "Asia/Taipei" })}
                {" ・ "}
                {statusLabel[a.status] ?? a.status}
              </span>
            </div>
          );
        })}
        {past.length === 0 && (
          <p className="text-sm text-foreground/50">還沒有歷史預約紀錄</p>
        )}
      </div>
    </main>
  );
}
