import { createClient } from "@/lib/supabase-server";
import { updateMaxAdvanceBookingDays } from "./actions";

export default async function SettingsPage({
  searchParams,
}: {
  searchParams: Promise<{ success?: string }>;
}) {
  const { success } = await searchParams;
  const supabase = await createClient();
  const { data } = await supabase
    .from("app_settings")
    .select("value")
    .eq("key", "booking_max_advance_days")
    .maybeSingle();
  const days = data?.value ?? "30";

  return (
    <main className="max-w-xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">系統設定</h1>

      {success && (
        <div className="mb-6 p-4 rounded-xl bg-primary-light text-primary-dark">
          已儲存！
        </div>
      )}

      <form
        action={updateMaxAdvanceBookingDays}
        className="flex flex-col gap-3 p-5 border border-primary-light rounded-xl bg-white"
      >
        <label className="flex flex-col gap-1 text-sm text-foreground/60">
          線上預約最多開放到幾天後
          <input
            name="booking_max_advance_days"
            type="number"
            min={1}
            required
            defaultValue={days}
            className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
          />
        </label>
        <p className="text-xs text-foreground/40">
          客人在「線上預約」頁面選日期時，最多只能選到今天起算這個天數之內，超過的日期不會開放。
        </p>
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
