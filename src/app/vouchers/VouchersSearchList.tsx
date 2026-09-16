"use client";

import { useMemo, useState } from "react";
import { Search } from "lucide-react";

const statusLabel: Record<string, string> = {
  active: "可使用",
  used: "已用完",
  expired: "已過期",
};

const statusStyle: Record<string, string> = {
  active: "text-primary-dark",
  used: "text-red-500",
  expired: "text-foreground/40",
};

type Voucher = {
  id: string;
  code: string | null;
  initial_value: number | null;
  remaining_value: number | null;
  status: string;
  expires_at: string | null;
  service_name: string | null;
  total_sessions: number | null;
  remaining_sessions: number | null;
  purchased_at: string | null;
  customers: { name: string; phone: string | null } | { name: string; phone: string | null }[] | null;
};

export default function VouchersSearchList({ vouchers }: { vouchers: Voucher[] }) {
  const [query, setQuery] = useState("");

  const rows = useMemo(
    () =>
      vouchers.map((v) => ({
        ...v,
        customer: Array.isArray(v.customers) ? v.customers[0] : v.customers,
      })),
    [vouchers]
  );

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (!q) return rows;
    return rows.filter(
      (v) =>
        v.customer?.name.toLowerCase().includes(q) || (v.customer?.phone ?? "").includes(q)
    );
  }, [rows, query]);

  return (
    <div>
      <div className="relative mb-4 max-w-sm">
        <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-foreground/40" />
        <input
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="搜尋客人姓名或電話"
          className="w-full border border-primary-light rounded-lg pl-9 pr-3 py-2 focus:outline-none focus:border-primary"
        />
      </div>

      <div className="flex flex-col gap-3">
        {filtered.map((v) => {
          const isSessionVoucher = v.total_sessions != null;
          return (
            <div
              key={v.id}
              className="p-4 border border-primary-light rounded-xl bg-white flex items-center justify-between gap-4"
            >
              <div>
                <p className="font-mono font-semibold">{v.service_name ?? v.code}</p>
                <p className="text-sm text-foreground/60">
                  {v.customer ? `${v.customer.name}（${v.customer.phone}）` : "通用券"}
                  {isSessionVoucher ? (
                    <>
                      {" "}
                      ・ 剩餘 {v.remaining_sessions} / {v.total_sessions} 堂 ・ 面額 $
                      {v.initial_value}
                    </>
                  ) : (
                    <>
                      {" "}
                      ・ 剩餘 ${v.remaining_value} / ${v.initial_value}
                    </>
                  )}
                  {v.purchased_at && <> ・ 購買於 {v.purchased_at}</>}
                  {v.expires_at && <> ・ 效期至 {v.expires_at}</>}
                </p>
              </div>
              <span className={`text-sm shrink-0 ${statusStyle[v.status] ?? "text-primary-dark"}`}>
                {statusLabel[v.status] ?? v.status}
              </span>
            </div>
          );
        })}
        {filtered.length === 0 && (
          <p className="text-center text-foreground/50 py-6">
            {rows.length === 0 ? "還沒有商品券" : "找不到符合的客人"}
          </p>
        )}
      </div>
    </div>
  );
}
