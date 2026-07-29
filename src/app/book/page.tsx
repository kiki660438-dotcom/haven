import { supabase } from "@/lib/supabase";
import { createBooking } from "./actions";

export default async function BookPage({
  searchParams,
}: {
  searchParams: Promise<{ success?: string }>;
}) {
  const { success } = await searchParams;
  const { data: services } = await supabase
    .from("services")
    .select("*")
    .order("name");

  return (
    <main className="max-w-xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">線上預約</h1>

      {success && (
        <div className="mb-6 p-4 rounded-xl bg-primary-light text-primary-dark">
          預約已送出！我們會盡快與您確認 🎉
        </div>
      )}

      <form
        action={createBooking}
        className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white"
      >
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
        <select
          name="service_id"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        >
          <option value="">選擇服務 *</option>
          {services?.map((s) => (
            <option key={s.id} value={s.id}>
              {s.name}（${s.price}／{s.duration_minutes}分）
            </option>
          ))}
        </select>
        <input
          name="start_time"
          type="datetime-local"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <button
          type="submit"
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          送出預約
        </button>
      </form>

      {services?.length === 0 && (
        <p className="mt-4 text-sm text-foreground/50">
          目前還沒有可選的服務項目，請先到「服務項目」頁面新增。
        </p>
      )}
    </main>
  );
}
