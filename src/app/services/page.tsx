import { createClient } from "@/lib/supabase-server";
import { addService, deleteService, updateService } from "./actions";

export default async function ServicesPage() {
  const supabase = await createClient();
  const { data: services } = await supabase
    .from("services")
    .select("*")
    .order("created_at", { ascending: false });

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">服務項目</h1>

      <form
        action={addService}
        className="grid grid-cols-2 gap-3 mb-8 p-4 border border-primary-light rounded-xl bg-white"
      >
        <input
          name="name"
          placeholder="服務名稱 * (例如：剪髮)"
          required
          className="border border-primary-light rounded-lg px-3 py-2 col-span-2 focus:outline-none focus:border-primary"
        />
        <input
          name="price"
          type="number"
          placeholder="價格 *"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="duration_minutes"
          type="number"
          placeholder="預估時長(分鐘)"
          defaultValue={60}
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <button
          type="submit"
          className="col-span-2 bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          新增服務
        </button>
      </form>

      <div className="overflow-x-auto">
      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">名稱</th>
            <th className="px-3">價格 / 時長（可直接調整）</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {services?.map((s) => (
            <tr key={s.id} className="border-b border-primary-light/60">
              <td className="py-2 px-3">{s.name}</td>
              <td className="px-3">
                <form
                  action={updateService.bind(null, s.id)}
                  className="flex items-center gap-2"
                >
                  <span>$</span>
                  <input
                    type="number"
                    name="price"
                    defaultValue={s.price}
                    className="w-20 border border-primary-light rounded-lg px-2 py-1"
                  />
                  <input
                    type="number"
                    name="duration_minutes"
                    defaultValue={s.duration_minutes}
                    className="w-16 border border-primary-light rounded-lg px-2 py-1"
                  />
                  <span className="text-foreground/50">分</span>
                  <span className="text-foreground/50">+緩衝</span>
                  <input
                    type="number"
                    name="buffer_minutes"
                    defaultValue={s.buffer_minutes ?? 0}
                    className="w-16 border border-primary-light rounded-lg px-2 py-1"
                  />
                  <span className="text-foreground/50">分</span>
                  <label className="flex items-center gap-1 text-sm whitespace-nowrap">
                    <input
                      type="checkbox"
                      name="hide_from_booking"
                      defaultChecked={s.hide_from_booking}
                    />
                    不開放線上預約
                  </label>
                  <button type="submit" className="text-primary-dark text-sm underline">
                    更新
                  </button>
                </form>
              </td>
              <td className="px-3">
                <form action={deleteService.bind(null, s.id)}>
                  <button type="submit" className="text-red-500 text-sm">
                    刪除
                  </button>
                </form>
              </td>
            </tr>
          ))}
          {services?.length === 0 && (
            <tr>
              <td colSpan={3} className="py-6 px-3 text-center text-foreground/50">
                還沒有服務項目
              </td>
            </tr>
          )}
        </tbody>
      </table>
      </div>
    </main>
  );
}
