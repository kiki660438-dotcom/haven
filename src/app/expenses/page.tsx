import { createClient } from "@/lib/supabase-server";
import { addExpense, deleteExpense } from "./actions";

const CATEGORIES = [
  "房租",
  "水費",
  "電費",
  "瓦斯費",
  "核定稅額",
  "中途狗狗雜支",
  "其他",
];

function monthKeyTaipei(dateStr: string) {
  return dateStr.slice(0, 7);
}

export default async function ExpensesPage() {
  const supabase = await createClient();
  const { data: expenses } = await supabase
    .from("fixed_expenses")
    .select("*")
    .order("expense_date", { ascending: false });

  const total = expenses?.reduce((sum, e) => sum + e.amount, 0) ?? 0;

  const currentMonth = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" })
    .format(new Date())
    .slice(0, 7);
  const monthTotal =
    expenses
      ?.filter((e) => monthKeyTaipei(e.expense_date) === currentMonth)
      .reduce((sum, e) => sum + e.amount, 0) ?? 0;

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">固定支出</h1>

      <div className="grid grid-cols-2 gap-4 mb-6">
        <div className="p-5 rounded-xl border border-primary-light bg-white">
          <p className="text-sm text-foreground/60 mb-1">本月支出</p>
          <p className="text-2xl font-bold text-primary-dark">${monthTotal}</p>
        </div>
        <div className="p-5 rounded-xl border border-primary-light bg-white">
          <p className="text-sm text-foreground/60 mb-1">累計支出</p>
          <p className="text-2xl font-bold text-primary-dark">${total}</p>
        </div>
      </div>

      <form
        action={addExpense}
        className="grid grid-cols-2 gap-3 mb-8 p-4 border border-primary-light rounded-xl bg-white"
      >
        <select
          name="category"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        >
          {CATEGORIES.map((c) => (
            <option key={c} value={c}>
              {c}
            </option>
          ))}
        </select>
        <input
          name="amount"
          type="number"
          placeholder="金額 *"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="expense_date"
          type="date"
          required
          defaultValue={new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(
            new Date()
          )}
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="note"
          placeholder="備註"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <button
          type="submit"
          className="col-span-2 bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          新增支出
        </button>
      </form>

      <div className="overflow-x-auto">
      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">日期</th>
            <th className="px-3">類別</th>
            <th className="px-3">金額</th>
            <th className="px-3">備註</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {expenses?.map((e) => (
            <tr key={e.id} className="border-b border-primary-light/60">
              <td className="py-2 px-3">{e.expense_date}</td>
              <td className="px-3">{e.category}</td>
              <td className="px-3">${e.amount}</td>
              <td className="px-3">{e.note}</td>
              <td className="px-3">
                <form action={deleteExpense.bind(null, e.id)}>
                  <button type="submit" className="text-red-500 text-sm">
                    刪除
                  </button>
                </form>
              </td>
            </tr>
          ))}
          {expenses?.length === 0 && (
            <tr>
              <td colSpan={5} className="py-6 px-3 text-center text-foreground/50">
                還沒有支出紀錄
              </td>
            </tr>
          )}
        </tbody>
      </table>
      </div>
    </main>
  );
}
