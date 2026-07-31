import { createClient } from "@/lib/supabase-server";
import { addStaff, deleteStaff, updateStaff } from "./actions";

export default async function StaffPage() {
  const supabase = await createClient();
  const { data: staff } = await supabase.from("staff").select("*").order("created_at");

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">員工資料</h1>

      <form
        action={addStaff}
        className="grid grid-cols-2 gap-3 mb-8 p-4 border border-primary-light rounded-xl bg-white"
      >
        <input
          name="name"
          placeholder="姓名 *"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <div className="flex items-center gap-2">
          <input
            name="commission_rate"
            type="number"
            step="0.1"
            defaultValue={30}
            className="w-24 border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
          />
          <span className="text-foreground/50">% 抽成</span>
        </div>
        <button
          type="submit"
          className="col-span-2 bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          新增員工
        </button>
      </form>

      <div className="overflow-x-auto">
      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">姓名</th>
            <th className="px-3">抽成 % / 在職</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {staff?.map((s) => (
            <tr key={s.id} className="border-b border-primary-light/60">
              <td className="py-2 px-3">{s.name}</td>
              <td className="px-3">
                <form
                  action={updateStaff.bind(null, s.id)}
                  className="flex items-center gap-2"
                >
                  <input
                    name="commission_rate"
                    type="number"
                    step="0.1"
                    defaultValue={s.commission_rate}
                    className="w-20 border border-primary-light rounded-lg px-2 py-1 text-sm"
                  />
                  <span className="text-foreground/50 text-sm">%</span>
                  <label className="flex items-center gap-1 text-sm">
                    <input type="checkbox" name="active" defaultChecked={s.active} />
                    在職
                  </label>
                  <button type="submit" className="text-primary-dark text-sm underline">
                    儲存
                  </button>
                </form>
              </td>
              <td className="px-3">
                <form action={deleteStaff.bind(null, s.id)}>
                  <button type="submit" className="text-red-500 text-sm">
                    刪除
                  </button>
                </form>
              </td>
            </tr>
          ))}
          {staff?.length === 0 && (
            <tr>
              <td colSpan={3} className="py-6 px-3 text-center text-foreground/50">
                還沒有員工資料
              </td>
            </tr>
          )}
        </tbody>
      </table>
      </div>
    </main>
  );
}
