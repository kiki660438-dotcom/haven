import { createClient } from "@/lib/supabase-server";
import { getMaxAdvanceBookingDate } from "../book/actions";
import { parseMonthlyOpen } from "@/lib/booking-window";
import { updateBookingWindow, updateNotifications } from "./actions";
import { getPushQuota } from "@/lib/line";

function todayTaipei() {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date());
}

const field =
  "border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary";

export default async function SettingsPage({
  searchParams,
}: {
  searchParams: Promise<{ success?: string }>;
}) {
  const { success } = await searchParams;
  const supabase = await createClient();
  const { data } = await supabase
    .from("app_settings")
    .select("key, value")
    .in("key", [
      "booking_open_until",
      "booking_monthly_open",
      "booking_max_advance_days",
      "notify_owner_new_booking",
      "notify_owner_changes",
      "notify_customer_reminder",
    ]);
  const get = (k: string) => data?.find((r) => r.key === k)?.value ?? "";

  const fixed = /^\d{4}-\d{2}-\d{2}$/.test(get("booking_open_until")) ? get("booking_open_until") : "";
  const monthly = parseMonthlyOpen(get("booking_monthly_open"));
  const days = get("booking_max_advance_days") || "30";
  const mode = fixed ? "fixed" : monthly ? "monthly" : "rolling";
  const [maxDate, quota] = await Promise.all([getMaxAdvanceBookingDate(), getPushQuota()]);
  const on = (k: string) => get(k) === "on";

  return (
    <main className="max-w-xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">系統設定</h1>

      {success && (
        <div className="mb-6 p-4 rounded-xl bg-primary-light text-primary-dark">已儲存！</div>
      )}

      <form
        action={updateBookingWindow}
        className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white"
      >
        <h2 className="font-semibold">開放預約</h2>

        <div className="p-3 rounded-lg bg-primary-light text-primary-dark text-sm">
          目前客人最多只能約到：<strong>{maxDate}</strong>
        </div>

        <label className="flex flex-col gap-2 p-3 rounded-lg border border-primary-light has-[:checked]:border-primary-dark has-[:checked]:bg-primary-light/40">
          <span className="flex items-center gap-2 text-sm font-medium">
            <input type="radio" name="mode" value="monthly" defaultChecked={mode === "monthly"} />
            每月固定時間，自動開放下個月（推薦）
          </span>
          <span className="flex items-center gap-2 text-sm text-foreground/70 pl-6 flex-wrap">
            每月
            <input
              name="monthly_day"
              type="number"
              min={1}
              max={28}
              defaultValue={monthly?.day ?? 15}
              className={`${field} w-16`}
            />
            號
            <input
              name="monthly_hour"
              type="number"
              min={0}
              max={23}
              defaultValue={monthly?.hour ?? 20}
              className={`${field} w-16`}
            />
            點，開放下個月整個月
          </span>
          <span className="text-xs text-foreground/40 pl-6">
            例如設 15 號 20 點：10/15 晚上 8 點一到，客人就能約到 11/30；在那之前只能約到 10/31。系統自己算，不用每月手動改。
          </span>
        </label>

        <label className="flex flex-col gap-2 p-3 rounded-lg border border-primary-light has-[:checked]:border-primary-dark has-[:checked]:bg-primary-light/40">
          <span className="flex items-center gap-2 text-sm font-medium">
            <input type="radio" name="mode" value="fixed" defaultChecked={mode === "fixed"} />
            自己指定開放到哪一天
          </span>
          <input
            name="booking_open_until"
            type="date"
            min={todayTaipei()}
            defaultValue={fixed}
            className={`${field} ml-6`}
          />
        </label>

        <label className="flex flex-col gap-2 p-3 rounded-lg border border-primary-light has-[:checked]:border-primary-dark has-[:checked]:bg-primary-light/40">
          <span className="flex items-center gap-2 text-sm font-medium">
            <input type="radio" name="mode" value="rolling" defaultChecked={mode === "rolling"} />
            從今天起算幾天（每天往後滑一天）
          </span>
          <span className="flex items-center gap-2 text-sm text-foreground/70 pl-6">
            最多約到今天起算
            <input
              name="booking_max_advance_days"
              type="number"
              min={1}
              defaultValue={days}
              className={`${field} w-20`}
            />
            天後
          </span>
        </label>

        <button
          type="submit"
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors self-start"
        >
          儲存
        </button>
      </form>

      <form
        action={updateNotifications}
        className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white mt-6"
      >
        <h2 className="font-semibold">LINE 通知</h2>

        <div className="p-3 rounded-lg bg-primary-light text-primary-dark text-sm">
          {quota ? (
            <>
              本月推播已使用 <strong>{quota.used}</strong>
              {quota.limit !== null ? ` / ${quota.limit}` : ""} 則
              {quota.limit !== null && quota.used >= quota.limit && "（額度已用完，通知暫時送不出去，下個月 1 號恢復）"}
            </>
          ) : (
            "目前查不到本月推播用量"
          )}
        </div>

        <p className="text-sm text-foreground/70">
          「確認預約」和「婉拒預約」通知客人，一定會送。下面的通知每一則都會用掉一則額度（免費方案每月 200 則），
          用不夠的話可以先關掉，或到 LINE 後台升級方案。
        </p>

        <label className="flex items-start gap-3 text-sm">
          <input type="checkbox" name="notify_owner_new_booking" defaultChecked={on("notify_owner_new_booking")} className="mt-1" />
          <span>
            有新的線上預約時，通知我
            <span className="block text-xs text-foreground/50">關閉時，請自己到「預約管理 → 待確認」查看</span>
          </span>
        </label>

        <label className="flex items-start gap-3 text-sm">
          <input type="checkbox" name="notify_owner_changes" defaultChecked={on("notify_owner_changes")} className="mt-1" />
          <span>客人改期或取消時，通知我</span>
        </label>

        <label className="flex items-start gap-3 text-sm">
          <input type="checkbox" name="notify_customer_reminder" defaultChecked={on("notify_customer_reminder")} className="mt-1" />
          <span>
            預約前一天，提醒客人
            <span className="block text-xs text-foreground/50">每天早上 10 點，傳給明天有預約、且有綁定 LINE 的客人</span>
          </span>
        </label>

        <button
          type="submit"
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors self-start"
        >
          儲存
        </button>
      </form>
    </main>
  );
}
