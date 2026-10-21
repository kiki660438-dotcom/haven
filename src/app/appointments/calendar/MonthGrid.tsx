"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { X } from "lucide-react";

export type ApptInfo = {
  id: string;
  time: string;
  name: string;
  phone: string;
  customerId: string | null;
  status: string;
  services: string;
  note: string | null;
  partySize: number;
};

export type DayCell = {
  key: string;
  day: number;
  inMonth: boolean;
  isToday: boolean;
  leaves: string[];
  appts: ApptInfo[];
};

const statusDot: Record<string, string> = {
  pending: "bg-yellow-400",
  confirmed: "bg-primary-dark",
  completed: "bg-gray-300",
};

const statusChip: Record<string, string> = {
  pending: "bg-yellow-100 text-yellow-800",
  confirmed: "bg-primary-light text-primary-dark",
  completed: "bg-gray-100 text-gray-500",
};

const statusLabel: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  completed: "已完成",
};

const WEEKDAYS = ["日", "一", "二", "三", "四", "五", "六"];
const MAX_CHIPS_PER_DAY = 3;

function dayTitle(key: string) {
  const [, m, d] = key.split("-").map(Number);
  const wd = new Date(`${key}T00:00:00Z`).getUTCDay();
  return `${m}月${d}日（${WEEKDAYS[wd]}）`;
}

export default function MonthGrid({ cells }: { cells: DayCell[] }) {
  const [openKey, setOpenKey] = useState<string | null>(null);
  const open = cells.find((c) => c.key === openKey) ?? null;

  useEffect(() => {
    if (!openKey) return;
    const onKey = (e: KeyboardEvent) => e.key === "Escape" && setOpenKey(null);
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [openKey]);

  return (
    <>
      <div className="grid grid-cols-7 gap-px sm:gap-1 bg-primary-light/70 sm:bg-transparent border-y border-primary-light/70 sm:border-0">
        {cells.map((c) => {
          const shown = c.appts.slice(0, MAX_CHIPS_PER_DAY);
          const extra = c.appts.length - shown.length;
          return (
            <button
              type="button"
              key={c.key}
              onClick={() => setOpenKey(c.key)}
              className={`min-h-24 sm:min-h-28 p-0.5 sm:p-1.5 sm:rounded-lg sm:border text-left flex flex-col gap-0.5 sm:gap-1 transition-colors touch-manipulation ${
                c.inMonth
                  ? `${c.isToday ? "bg-primary-light/50" : "bg-white"} sm:border-primary-light hover:bg-primary-light/40`
                  : "bg-gray-50 sm:border-gray-100 text-foreground/30 hover:bg-gray-100"
              }`}
            >
              <span
                className={`text-xs w-5 h-5 flex items-center justify-center rounded-full ${
                  c.isToday ? "bg-primary-dark text-white font-semibold" : ""
                }`}
              >
                {c.day}
              </span>
              {c.leaves.map((l, i) => (
                <span
                  key={`leave-${i}`}
                  className="block rounded px-0.5 text-[11px] leading-[14px] bg-sky-100 text-sky-700 sm:truncate"
                >
                  {l}
                </span>
              ))}
              <div className="flex sm:hidden flex-col gap-0.5 w-full">
                {c.appts.map((a) => (
                  <span
                    key={a.id}
                    className={`block break-all rounded px-0.5 text-[11px] leading-[14px] ${
                      statusChip[a.status] ?? "bg-gray-100 text-gray-600"
                    }`}
                  >
                    {a.name}
                  </span>
                ))}
              </div>
              <div className="hidden sm:flex flex-col gap-0.5 w-full">
                {shown.map((a) => (
                  <span key={a.id} className="flex items-center gap-1 text-[11px] leading-tight truncate">
                    <span className={`shrink-0 w-1.5 h-1.5 rounded-full ${statusDot[a.status] ?? "bg-gray-300"}`} />
                    <span className="truncate">
                      {a.time} {a.name}
                    </span>
                  </span>
                ))}
                {extra > 0 && <span className="text-[11px] text-foreground/40">+{extra} 筆</span>}
              </div>
            </button>
          );
        })}
      </div>

      {open && (
        <div
          className="fixed inset-0 z-50 flex items-end sm:items-center justify-center bg-black/40"
          onClick={() => setOpenKey(null)}
        >
          <div
            role="dialog"
            aria-label={`${dayTitle(open.key)}的預約`}
            className="w-full sm:max-w-md max-h-[80vh] overflow-y-auto bg-white rounded-t-2xl sm:rounded-2xl p-5 shadow-xl"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-start justify-between gap-3 mb-3">
              <div>
                <p className="text-lg font-bold text-primary-dark">{dayTitle(open.key)}</p>
                <p className="text-xs text-foreground/50">共 {open.appts.length} 位客人</p>
              </div>
              <button
                type="button"
                onClick={() => setOpenKey(null)}
                aria-label="關閉"
                className="p-2 -m-2 rounded-full hover:bg-primary-light text-foreground/60"
              >
                <X size={20} />
              </button>
            </div>

            {open.leaves.length > 0 && (
              <div className="mb-3 flex flex-wrap gap-1.5">
                {open.leaves.map((l, i) => (
                  <span key={i} className="text-xs px-2 py-1 rounded-full bg-sky-100 text-sky-700">
                    {l}
                  </span>
                ))}
              </div>
            )}

            {open.appts.length === 0 ? (
              <p className="text-center text-foreground/50 py-6">這天沒有預約</p>
            ) : (
              <div className="flex flex-col gap-2">
                {open.appts.map((a) => (
                  <div key={a.id} className="rounded-xl border border-primary-light p-3">
                    <div className="flex items-start justify-between gap-2">
                      <p>
                        <span className="font-bold text-primary-dark mr-2">{a.time}</span>
                        {a.customerId ? (
                          <Link href={`/members/${a.customerId}`} className="font-semibold underline decoration-dotted underline-offset-2">
                            {a.name}
                          </Link>
                        ) : (
                          <span className="font-semibold">{a.name}</span>
                        )}
                        {a.partySize > 1 && (
                          <span className="ml-2 text-xs px-2 py-0.5 rounded-full bg-orange-100 text-orange-700">
                            {a.partySize} 位
                          </span>
                        )}
                      </p>
                      <span
                        className={`text-xs px-2 py-1 rounded-full whitespace-nowrap ${
                          statusChip[a.status] ?? "bg-gray-100 text-gray-500"
                        }`}
                      >
                        {statusLabel[a.status] ?? a.status}
                      </span>
                    </div>
                    <p className="text-sm text-foreground/70 mt-1">{a.services}</p>
                    {a.phone && <p className="text-xs text-foreground/50 mt-0.5">{a.phone}</p>}
                    {a.note && <p className="text-xs text-foreground/50 mt-0.5">備註：{a.note}</p>}
                  </div>
                ))}
              </div>
            )}

            <Link
              href={`/appointments/day?date=${open.key}`}
              className="block text-center text-sm text-primary-dark underline mt-4"
            >
              開啟完整當日頁面（可確認、開單）
            </Link>
          </div>
        </div>
      )}
    </>
  );
}
