"use client";

import { useState } from "react";
import { ChevronLeft, ChevronRight } from "lucide-react";

const WEEKDAYS = ["日", "一", "二", "三", "四", "五", "六"];

function pad(n: number) {
  return String(n).padStart(2, "0");
}

export default function DatePicker({
  name,
  min,
  max,
  closed,
  defaultValue,
}: {
  name: string;
  min: string;
  max: string;
  closed: string[];
  defaultValue?: string;
}) {
  const closedSet = new Set(closed);
  const initial = defaultValue && defaultValue >= min && defaultValue <= max ? defaultValue : "";
  const [selected, setSelected] = useState(initial);
  const [month, setMonth] = useState((initial || min).slice(0, 7));

  const [y, m] = month.split("-").map(Number);
  const firstWeekday = new Date(Date.UTC(y, m - 1, 1)).getUTCDay();
  const daysInMonth = new Date(Date.UTC(y, m, 0)).getUTCDate();
  const cells: (string | null)[] = [
    ...Array<null>(firstWeekday).fill(null),
    ...Array.from({ length: daysInMonth }, (_, i) => `${y}-${pad(m)}-${pad(i + 1)}`),
  ];

  const shiftMonth = (delta: number) => {
    const d = new Date(Date.UTC(y, m - 1 + delta, 1));
    setMonth(`${d.getUTCFullYear()}-${pad(d.getUTCMonth() + 1)}`);
  };

  return (
    <div className="flex flex-col gap-2">
      <input
        name={name}
        value={selected}
        onChange={() => {}}
        required
        autoComplete="off"
        inputMode="none"
        placeholder="請從下方月曆選擇日期"
        className="border border-primary-light rounded-lg px-3 py-2 text-sm bg-white focus:outline-none"
      />

      <div className="border border-primary-light rounded-xl p-3 bg-white">
        <div className="flex items-center justify-between mb-2">
          <button
            type="button"
            onClick={() => shiftMonth(-1)}
            disabled={month <= min.slice(0, 7)}
            aria-label="上個月"
            className="p-2 rounded-lg hover:bg-primary-light disabled:opacity-25 touch-manipulation"
          >
            <ChevronLeft size={18} />
          </button>
          <span className="font-medium text-primary-dark">
            {y} 年 {m} 月
          </span>
          <button
            type="button"
            onClick={() => shiftMonth(1)}
            disabled={month >= max.slice(0, 7)}
            aria-label="下個月"
            className="p-2 rounded-lg hover:bg-primary-light disabled:opacity-25 touch-manipulation"
          >
            <ChevronRight size={18} />
          </button>
        </div>

        <div className="grid grid-cols-7 gap-1 text-center text-xs text-foreground/50 mb-1">
          {WEEKDAYS.map((w) => (
            <div key={w}>{w}</div>
          ))}
        </div>

        <div className="grid grid-cols-7 gap-1">
          {cells.map((d, i) => {
            if (!d) return <div key={`b${i}`} />;
            const day = Number(d.slice(8));
            const isClosed = closedSet.has(d);
            const outOfRange = d < min || d > max;
            const isSelected = d === selected;

            let style = "text-foreground hover:bg-primary-light";
            if (outOfRange) style = "text-foreground/25";
            else if (isClosed) style = "bg-red-50 text-red-400";
            if (isSelected) style = "bg-primary-dark text-white";

            return (
              <button
                key={d}
                type="button"
                disabled={outOfRange || isClosed}
                onClick={() => setSelected(d)}
                aria-label={`${d}${isClosed ? " 公休" : ""}`}
                className={`h-11 rounded-lg text-sm flex flex-col items-center justify-center leading-tight touch-manipulation ${style}`}
              >
                <span>{day}</span>
                {isClosed && !outOfRange && <span className="text-[10px]">休</span>}
              </button>
            );
          })}
        </div>

        <p className="text-xs text-foreground/50 mt-3">
          紅底「休」是公休日，無法預約；灰色日期尚未開放。
        </p>
      </div>
    </div>
  );
}
