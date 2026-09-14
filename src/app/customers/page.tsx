import { createClient } from "@/lib/supabase-server";
import { addCustomer } from "./actions";
import CustomersSearchTable from "./CustomersSearchTable";

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

      <CustomersSearchTable customers={customers ?? []} />
    </main>
  );
}
