"use client";

import { useActionState, useState } from "react";
import CustomerPicker from "../../checkout/CustomerPicker";
import { mergeCustomers, type MergeState } from "./actions";

type Customer = { id: string; name: string; phone: string | null };

export default function MergeCustomerPanel({
  customerId,
  customerName,
  customers,
  suggestions,
}: {
  customerId: string;
  customerName: string;
  customers: Customer[];
  suggestions: Customer[];
}) {
  const [state, formAction, pending] = useActionState<MergeState, FormData>(
    mergeCustomers.bind(null, customerId),
    null
  );
  const [open, setOpen] = useState(suggestions.length > 0);
  const others = customers.filter((c) => c.id !== customerId);

  const confirmMerge = (e: React.FormEvent<HTMLFormElement>, label: string) => {
    if (!window.confirm(`確定要把「${customerName}」和「${label}」合併成一位客人嗎？合併後無法復原。`)) {
      e.preventDefault();
    }
  };

  return (
    <div className="mt-4 p-4 border border-primary-light rounded-xl bg-white">
      <button
        type="button"
        onClick={() => setOpen(!open)}
        className="text-sm font-semibold text-primary-dark"
      >
        合併重複的客人 {open ? "▲" : "▼"}
      </button>

      {open && (
        <div className="mt-3 flex flex-col gap-3">
          <p className="text-xs text-foreground/60">
            同一位客人有兩筆資料時（例如用 LINE 登入自動建立、沒有電話的那筆），可以合併成一筆。
            會留下有電話的那一筆，預約、消費紀錄、商品券、配方紀錄、LINE 綁定都會移過去。
          </p>

          {suggestions.length > 0 && (
            <div className="flex flex-col gap-2">
              <p className="text-xs text-foreground/50">可能是同一個人：</p>
              {suggestions.map((s) => (
                <form
                  key={s.id}
                  action={formAction}
                  onSubmit={(e) => confirmMerge(e, s.name)}
                  className="flex items-center justify-between gap-2 p-2 rounded-lg bg-primary-light/50"
                >
                  <input type="hidden" name="other_id" value={s.id} />
                  <span className="text-sm">
                    {s.name}
                    <span className="text-foreground/50 ml-2">{s.phone ?? "沒有電話"}</span>
                  </span>
                  <button
                    type="submit"
                    disabled={pending}
                    className="text-sm px-3 py-1.5 rounded-lg bg-primary-dark text-white disabled:opacity-60 touch-manipulation"
                  >
                    合併
                  </button>
                </form>
              ))}
            </div>
          )}

          <form
            action={formAction}
            onSubmit={(e) => confirmMerge(e, "選擇的客人")}
            className="flex flex-col gap-2"
          >
            <p className="text-xs text-foreground/50">或搜尋其他客人：</p>
            <CustomerPicker customers={others} name="other_id" />
            <button
              type="submit"
              disabled={pending}
              className="self-start text-sm px-3 py-1.5 rounded-lg border border-primary-light text-primary-dark disabled:opacity-60 touch-manipulation"
            >
              {pending ? "合併中…" : "合併這位客人"}
            </button>
          </form>

          {state && !state.ok && <p className="text-sm text-red-500">{state.error}</p>}
        </div>
      )}
    </div>
  );
}
