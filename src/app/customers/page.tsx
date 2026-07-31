import { createClient } from "@/lib/supabase-server";
import { addCustomer, deleteCustomer, updateCustomerDemographics } from "./actions";

export default async function CustomersPage() {
  const supabase = await createClient();
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
          name="birthday"
          type="date"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <select
          name="gender"
          defaultValue=""
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        >
          <option value="">性別（選填）</option>
          <option value="male">男</option>
          <option value="female">女</option>
          <option value="other">不透露</option>
        </select>
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

      <div className="overflow-x-auto">
      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">姓名</th>
            <th className="px-3">電話</th>
            <th className="px-3">Email</th>
            <th className="px-3">備註</th>
            <th className="px-3">生日 / 性別</th>
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
                <form
                  action={updateCustomerDemographics.bind(null, c.id)}
                  className="flex items-center gap-1"
                >
                  <input
                    name="birthday"
                    type="date"
                    defaultValue={c.birthday ?? ""}
                    className="border border-primary-light rounded-lg px-2 py-1 text-sm w-36 focus:outline-none focus:border-primary"
                  />
                  <select
                    name="gender"
                    defaultValue={c.gender ?? ""}
                    className="border border-primary-light rounded-lg px-2 py-1 text-sm focus:outline-none focus:border-primary"
                  >
                    <option value="">-</option>
                    <option value="male">男</option>
                    <option value="female">女</option>
                    <option value="other">不透露</option>
                  </select>
                  <button type="submit" className="text-primary-dark text-sm underline">
                    儲存
                  </button>
                </form>
              </td>
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
              <td colSpan={6} className="py-6 px-3 text-center text-foreground/50">
                還沒有客戶資料
              </td>
            </tr>
          )}
        </tbody>
      </table>
      </div>
    </main>
  );
}
