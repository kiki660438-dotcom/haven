import { createClient } from "@/lib/supabase-server";
import { addClosedDate, deleteClosedDate } from "./actions";

function todayKey() {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date());
}

export default async function ClosedDatesPage() {
  const supabase = await createClient();
  const { data: closedDates } = await supabase
    .from("closed_dates")
    .select("id, date, note")
    .order("date", { ascending: true });

  const today = todayKey();
  const upcoming = (closedDates ?? []).filter((d) => d.date >= today);
  const past = (closedDates ?? []).filter((d) => d.date < today);

  return (
    <main className="max-w-xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-2">公休日設定</h1>
      <p className="text-sm text-foreground/50 mb-6">
        設定的日期，客人在線上預約會完全約不到，不會顯示任何可預約時段。
      </p>

      <form
        action={addClosedDate}
        className="flex flex-col gap-3 mb-8 p-4 border border-primary-light rounded-xl bg-white"
      >
        <input
          name="date"
          type="date"
          required
          min={today}
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="note"
          placeholder="備註（選填，例如：過年公休）"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <button
          type="submit"
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          新增公休日
        </button>
      </form>

      <h2 className="font-semibold mb-2">即將到來的公休日</h2>
      <div className="flex flex-col gap-2 mb-8">
        {upcoming.map((d) => (
          <div
            key={d.id}
            className="flex items-center justify-between p-3 border border-primary-light rounded-xl bg-white"
          >
            <div>
              <p className="font-semibold">{d.date}</p>
              {d.note && <p className="text-sm text-foreground/60">{d.note}</p>}
            </div>
            <form action={deleteClosedDate.bind(null, d.id)}>
              <button type="submit" className="text-red-500 text-sm">
                取消公休
              </button>
            </form>
          </div>
        ))}
        {upcoming.length === 0 && (
          <p className="text-center text-foreground/50 py-6">目前沒有設定公休日</p>
        )}
      </div>

      {past.length > 0 && (
        <>
          <h2 className="font-semibold mb-2 text-foreground/50">過去的公休日</h2>
          <div className="flex flex-col gap-2">
            {past.map((d) => (
              <div
                key={d.id}
                className="flex items-center justify-between p-3 border border-primary-light rounded-xl bg-white text-foreground/50"
              >
                <div>
                  <p>{d.date}</p>
                  {d.note && <p className="text-sm">{d.note}</p>}
                </div>
              </div>
            ))}
          </div>
        </>
      )}
    </main>
  );
}
