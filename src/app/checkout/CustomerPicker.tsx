"use client";

import { useEffect, useMemo, useRef, useState } from "react";

type Customer = { id: string; name: string; phone: string | null };

export default function CustomerPicker({
  customers,
  name,
  defaultCustomerId,
  defaultLabel,
}: {
  customers: Customer[];
  name: string;
  defaultCustomerId?: string;
  defaultLabel?: string;
}) {
  const [query, setQuery] = useState(defaultLabel ?? "");
  const [selectedId, setSelectedId] = useState(defaultCustomerId ?? "");
  const [open, setOpen] = useState(false);
  const containerRef = useRef<HTMLDivElement>(null);

  const matches = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (!q) return [];
    return customers
      .filter((c) => c.name.toLowerCase().includes(q) || (c.phone ?? "").includes(q))
      .slice(0, 8);
  }, [query, customers]);

  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  return (
    <div ref={containerRef} className="relative">
      <input type="hidden" name={name} value={selectedId} />
      <input
        type="text"
        value={query}
        onChange={(e) => {
          setQuery(e.target.value);
          setSelectedId("");
          setOpen(true);
        }}
        onFocus={() => setOpen(true)}
        placeholder="輸入姓名或電話搜尋（不選則為現場客）"
        className="w-full border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
      />
      {open && matches.length > 0 && (
        <div className="absolute z-10 mt-1 w-full max-h-64 overflow-y-auto border border-primary-light rounded-lg bg-white shadow-md">
          {matches.map((c) => (
            <button
              type="button"
              key={c.id}
              onClick={() => {
                setSelectedId(c.id);
                setQuery(`${c.name}（${c.phone ?? ""}）`);
                setOpen(false);
              }}
              className="block w-full text-left px-3 py-2 text-sm hover:bg-primary-light"
            >
              {c.name}
              <span className="text-foreground/50"> {c.phone}</span>
            </button>
          ))}
        </div>
      )}
      {selectedId && (
        <p className="text-xs text-primary-dark mt-1">
          已選擇會員
          <button
            type="button"
            onClick={() => {
              setSelectedId("");
              setQuery("");
            }}
            className="ml-2 underline text-foreground/50"
          >
            清除改為現場客
          </button>
        </p>
      )}
    </div>
  );
}
