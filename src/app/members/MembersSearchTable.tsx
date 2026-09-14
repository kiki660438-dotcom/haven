"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import { Search } from "lucide-react";

const genderLabel: Record<string, string> = {
  male: "男",
  female: "女",
  other: "不透露",
};

type Row = {
  id: string;
  name: string;
  phone: string | null;
  age: number | null;
  gender: string | null;
  totalSpent: number;
  visitCount: number;
  lastVisit: string | undefined;
};

export default function MembersSearchTable({ rows }: { rows: Row[] }) {
  const [query, setQuery] = useState("");

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (!q) return rows;
    return rows.filter(
      (r) => r.name.toLowerCase().includes(q) || (r.phone ?? "").includes(q)
    );
  }, [rows, query]);

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
              <th className="px-3">年齡 / 性別</th>
              <th className="px-3">消費次數</th>
              <th className="px-3">累計消費</th>
              <th className="px-3">最近消費</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {filtered.map((r) => (
              <tr key={r.id} className="border-b border-primary-light/60">
                <td className="py-2 px-3">{r.name}</td>
                <td className="px-3">{r.phone}</td>
                <td className="px-3">
                  {r.age ?? "-"}
                  {r.gender ? ` / ${genderLabel[r.gender] ?? r.gender}` : ""}
                </td>
                <td className="px-3">{r.visitCount}</td>
                <td className="px-3">${r.totalSpent}</td>
                <td className="px-3">
                  {r.lastVisit
                    ? new Date(r.lastVisit).toLocaleDateString("zh-TW", { timeZone: "Asia/Taipei" })
                    : "-"}
                </td>
                <td className="px-3">
                  <Link href={`/members/${r.id}`} className="text-primary-dark text-sm underline">
                    查看明細
                  </Link>
                </td>
              </tr>
            ))}
            {filtered.length === 0 && (
              <tr>
                <td colSpan={7} className="py-6 px-3 text-center text-foreground/50">
                  {rows.length === 0 ? "還沒有會員消費紀錄" : "找不到符合的會員"}
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
