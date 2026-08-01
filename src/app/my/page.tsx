import { cookies } from "next/headers";
import { supabase } from "@/lib/supabase";
import { verifyCustomerToken, CUSTOMER_COOKIE } from "@/lib/customer-identity";
import { verifyPhone, logoutCustomer } from "../book/actions";
import { cancelMyAppointment } from "./actions";

const statusLabel: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  cancelled: "已取消",
  completed: "已完成",
};

export default async function MyPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string }>;
}) {
  const { error } = await searchParams;
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
            <button
              type="submit"
              className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
            >
              電話登入
            </button>
          </form>

          <a href={lineLoginUrl} className="text-center text-sm underline text-primary-dark">
            沒有台灣手機號碼？點此使用 LINE 帳號登入
          </a>
        </div>
      </main>
    );
  }

  const [{ data: appointments }, { data: vouchers }] = await Promise.all([
    supabase
      .from("appointments")
      .select("id, start_time, status, services(name, price)")
      .eq("customer_id", identity.customerId)
      .order("start_time", { ascending: false }),
    supabase
      .from("vouchers")
      .select("id, service_name, total_sessions, remaining_sessions, purchased_at, status")
      .eq("customer_id", identity.customerId)
      .order("purchased_at", { ascending: false }),
  ]);

  const now = Date.now();
  const upcoming = (appointments ?? []).filter(
    (a) => a.status !== "cancelled" && a.status !== "completed" && new Date(a.start_time).getTime() >= now
  );
  const past = (appointments ?? []).filter((a) => !upcoming.includes(a));
  const activeVouchers = (vouchers ?? []).filter((v) => v.status === "active");

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

      <h2 className="font-semibold mb-3">即將到來的預約</h2>
      <div className="flex flex-col gap-2 mb-6">
        {upcoming.map((a) => {
          const service = Array.isArray(a.services) ? a.services[0] : a.services;
          return (
            <div
              key={a.id}
              className="p-4 border border-primary-light rounded-xl bg-white flex items-center justify-between gap-3"
            >
              <div>
                <p className="font-medium">{service?.name}</p>
                <p className="text-sm text-foreground/60">
                  {new Date(a.start_time).toLocaleString("zh-TW", { timeZone: "Asia/Taipei" })}
                  {" ・ "}
                  {statusLabel[a.status] ?? a.status}
                </p>
              </div>
              <form action={cancelMyAppointment.bind(null, a.id)}>
                <button type="submit" className="text-red-500 text-sm whitespace-nowrap">
                  取消預約
                </button>
              </form>
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
          </div>
        ))}
        {activeVouchers.length === 0 && (
          <p className="text-sm text-foreground/50">目前沒有商品券</p>
        )}
      </div>

      <h2 className="font-semibold mb-3">歷史預約</h2>
      <div className="flex flex-col gap-2">
        {past.map((a) => {
          const service = Array.isArray(a.services) ? a.services[0] : a.services;
          return (
            <div
              key={a.id}
              className="p-3 border border-primary-light rounded-xl bg-white text-sm text-foreground/70 flex items-center justify-between"
            >
              <span>{service?.name}</span>
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
