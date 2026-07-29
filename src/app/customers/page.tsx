import { supabase } from "@/lib/supabase";
import { addCustomer, deleteCustomer } from "./actions";

export default async function CustomersPage() {
  const { data: customers } = await supabase
    .from("customers")
    .select("*")
    .order("created_at", { ascending: false });

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">客戶資料管理</h1>

      <form
        action={addCustomer}
        className="grid grid-cols-2 gap-3 mb-8 p-4 border border-primary-light rounded-xl bg-white"
      >
        <input
          name="name"
          placeholder="姓名 *"
          required
          className="border border-primary-light rounded-lg px-3 py-2 col-span-2 focus:outline-none focus:border-primary"
        />
        <input
          name="phone"
          placeholder="電話"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="email"
          placeholder="Email"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="note"
          placeholder="備註"
          className="border border-primary-light rounded-lg px-3 py-2 col-span-2 focus:outline-none focus:border-primary"
        />
        <button
          type="submit"
          className="col-span-2 bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          新增客戶
        </button>
      </form>

      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">姓名</th>
            <th className="px-3">電話</th>
            <th className="px-3">Email</th>
            <th className="px-3">備註</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {customers?.map((c) => (
            <tr key={c.id} className="border-b border-primary-light/60">
              <td className="py-2 px-3">{c.name}</td>
              <td className="px-3">{c.phone}</td>
              <td className="px-3">{c.email}</td>
              <td className="px-3">{c.note}</td>
              <td className="px-3">
                <form action={deleteCustomer.bind(null, c.id)}>
                  <button type="submit" className="text-red-500 text-sm">
                    刪除
                  </button>
                </form>
              </td>
            </tr>
          ))}
          {customers?.length === 0 && (
            <tr>
              <td colSpan={5} className="py-6 px-3 text-center text-foreground/50">
                還沒有客戶資料
              </td>
            </tr>
          )}
        </tbody>
      </table>
    </main>
  );
}
