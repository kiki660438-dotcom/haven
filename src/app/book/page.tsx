import { supabase } from "@/lib/supabase";
import { createBooking, getAvailableSlots } from "./actions";

export default async function BookPage({
  searchParams,
}: {
  searchParams: Promise<{ success?: string; error?: string; service_id?: string; date?: string }>;
}) {
  const { success, error, service_id, date } = await searchParams;
  const { data: services } = await supabase
    .from("services")
    .select("*")
    .order("name");

  const slots =
    service_id && date ? await getAvailableSlots(service_id, date) : null;

  return (
    <main className="max-w-xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">線上預約</h1>

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
          請選擇一個可預約時段。
        </div>
      )}

      <form
        method="GET"
        action="/book"
        className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white mb-6"
      >
        <select
          name="service_id"
          required
          defaultValue={service_id ?? ""}
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        >
          <option value="">選擇服務 *</option>
          {services?.map((s) => (
            <option key={s.id} value={s.id}>
              {s.name}（${s.price}）
            </option>
          ))}
        </select>
        <input
          name="date"
          type="date"
          required
          defaultValue={date ?? ""}
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <button
          type="submit"
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          查詢可預約時段
        </button>
      </form>

      {slots && (
        <form
          action={createBooking}
          className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white"
        >
          <input type="hidden" name="service_id" value={service_id} />
          <input type="hidden" name="date" value={date} />

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
