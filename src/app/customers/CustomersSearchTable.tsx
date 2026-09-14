"use client";

import { useMemo, useState } from "react";
import { Search } from "lucide-react";
import { deleteCustomer, updateCustomerDemographics } from "./actions";

type Customer = {
  id: string;
  name: string;
  phone: string | null;
  email: string | null;
  note: string | null;
  birthday: string | null;
  gender: string | null;
};

export default function CustomersSearchTable({ customers }: { customers: Customer[] }) {
  const [query, setQuery] = useState("");

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (!q) return customers;
    return customers.filter(
      (c) => c.name.toLowerCase().includes(q) || (c.phone ?? "").includes(q)
    );
  }, [customers, query]);

  return (
    <div>
      <div className="relative mb-4 max-w-sm">
        <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-foreground/40" />
        <input
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="搜尋姓名或電話"
          className="w-full border border-primary-light rounded-lg pl-9 pr-3 py-2 focus:outline-none focus:border-primary"
        />
      </div>

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
            {filtered.map((c) => (
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
            {filtered.length === 0 && (
              <tr>
                <td colSpan={6} className="py-6 px-3 text-center text-foreground/50">
                  {customers.length === 0 ? "還沒有客戶資料" : "找不到符合的客戶"}
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
