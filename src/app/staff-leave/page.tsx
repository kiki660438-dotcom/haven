import { createClient } from "@/lib/supabase-server";
import { addStaffLeave, deleteStaffLeave } from "./actions";

const HOUR_OPTIONS = Array.from({ length: 24 }, (_, h) => `${String(h).padStart(2, "0")}:00`);

function todayKey() {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date());
}

export default async function StaffLeavePage() {
  const supabase = await createClient();
  const [{ data: leaveRows }, { data: staffList }] = await Promise.all([
    supabase
      .from("staff_leave")
      .select("id, staff_id, start_date, end_date, all_day, start_time, end_time, note, staff(name)")
      .order("start_date", { ascending: true }),
    supabase.from("staff").select("id, name").eq("active", true).order("name"),
  ]);

  const today = todayKey();
  const upcoming = (leaveRows ?? []).filter((d) => d.end_date >= today);
  const past = (leaveRows ?? []).filter((d) => d.end_date < today);

  const describe = (row: (typeof upcoming)[number]) => {
    const staff = Array.isArray(row.staff) ? row.staff[0] : row.staff;
    const who = staff?.name ?? "全門店";
    const range = row.start_date === row.end_date ? row.start_date : `${row.start_date} ~ ${row.end_date}`;
    const time = row.all_day ? "整天" : `${row.start_time?.slice(0, 5)} ~ ${row.end_time?.slice(0, 5)}`;
    return { who, range, time };
  };

  return (
    <main className="max-w-xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-2">請假／排休設定</h1>
      <p className="text-sm text-foreground/50 mb-6">
        設定的時間，客人在線上預約會約不到；選「全門店」等於整間店公休，選特定設計師則只擋那位設計師。
      </p>

      <form
        action={addStaffLeave}
        className="flex flex-col gap-3 mb-8 p-4 border border-primary-light rounded-xl bg-white"
      >
        <div className="flex gap-3">
          <label className="flex-1 flex flex-col gap-1 text-sm text-foreground/60">
            開始日期 *
            <input
              name="start_date"
              type="date"
              required
              min={today}
              className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
            />
          </label>
          <label className="flex-1 flex flex-col gap-1 text-sm text-foreground/60">
            結束日期（不填同開始日期）
            <input
              name="end_date"
              type="date"
              min={today}
              className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
            />
          </label>
        </div>

        <label className="flex items-center gap-2 text-sm">
          <input type="checkbox" name="all_day" defaultChecked />
          整天（不指定時段就整天請假）
        </label>

        <div className="flex gap-3">
          <label className="flex-1 flex flex-col gap-1 text-sm text-foreground/60">
            開始時間（只在非整天時有效，24小時制，整點）
            <select
              name="start_time"
              defaultValue="11:00"
              className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
            >
              {HOUR_OPTIONS.map((h) => (
                <option key={h} value={h}>
                  {h}
                </option>
              ))}
            </select>
          </label>
          <label className="flex-1 flex flex-col gap-1 text-sm text-foreground/60">
            結束時間
            <select
              name="end_time"
              defaultValue="18:00"
              className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
            >
              {HOUR_OPTIONS.map((h) => (
                <option key={h} value={h}>
                  {h}
                </option>
              ))}
            </select>
          </label>
        </div>

        <label className="flex items-center gap-2 text-sm">
          <input type="checkbox" name="whole_store" />
          設定為「全門店」請假（整間店公休，優先於下面的設計師選擇）
        </label>

        <select
          name="staff_id"
          defaultValue=""
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        >
          <option value="">選擇設計師</option>
          {staffList?.map((s) => (
            <option key={s.id} value={s.id}>
              {s.name}
            </option>
          ))}
        </select>

        <input
          name="note"
          placeholder="備註（選填，例如：過年公休、進修）"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />

        <button
          type="submit"
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          新增請假／排休
        </button>
      </form>

      <h2 className="font-semibold mb-2">即將到來</h2>
      <div className="flex flex-col gap-2 mb-8">
        {upcoming.map((d) => {
          const { who, range, time } = describe(d);
          return (
            <div
              key={d.id}
              className="flex items-center justify-between p-3 border border-primary-light rounded-xl bg-white"
            >
              <div>
                <p className="font-semibold">
                  {who} ・ {range}
                </p>
                <p className="text-sm text-foreground/60">
                  {time}
                  {d.note ? ` ・ ${d.note}` : ""}
                </p>
              </div>
              <form action={deleteStaffLeave.bind(null, d.id)}>
                <button type="submit" className="text-red-500 text-sm">
                  取消
                </button>
              </form>
            </div>
          );
        })}
        {upcoming.length === 0 && (
          <p className="text-center text-foreground/50 py-6">目前沒有安排請假／排休</p>
        )}
      </div>

      {past.length > 0 && (
        <>
          <h2 className="font-semibold mb-2 text-foreground/50">過去的紀錄</h2>
          <div className="flex flex-col gap-2">
            {past.map((d) => {
              const { who, range, time } = describe(d);
              return (
                <div
                  key={d.id}
                  className="p-3 border border-primary-light rounded-xl bg-white text-foreground/50"
                >
                  <p>
                    {who} ・ {range}
                  </p>
                  <p className="text-sm">
                    {time}
                    {d.note ? ` ・ ${d.note}` : ""}
                  </p>
                </div>
              );
            })}
          </div>
        </>
      )}
    </main>
  );
}
