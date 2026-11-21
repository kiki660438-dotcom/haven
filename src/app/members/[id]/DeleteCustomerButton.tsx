"use client";

import { useActionState } from "react";
import { Trash2 } from "lucide-react";
import { deleteCustomerSafely, type DeleteState } from "./actions";

export default function DeleteCustomerButton({
  customerId,
  customerName,
}: {
  customerId: string;
  customerName: string;
}) {
  const [state, formAction, pending] = useActionState<DeleteState, FormData>(
    () => deleteCustomerSafely(customerId),
    null
  );

  return (
    <form
      action={formAction}
      onSubmit={(e) => {
        if (!window.confirm(`確定要刪除「${customerName}」嗎？刪除後無法復原。`)) e.preventDefault();
      }}
      className="mt-4 p-4 border border-red-100 rounded-xl bg-white"
    >
      <p className="text-xs text-foreground/60 mb-2">
        只能刪除沒有任何訂單、預約、商品券、配方紀錄的客人（例如建錯的空白資料）。
      </p>
      <button
        type="submit"
        disabled={pending}
        className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-red-200 text-red-500 hover:bg-red-50 disabled:opacity-60 touch-manipulation"
      >
        <Trash2 size={14} /> {pending ? "刪除中…" : "刪除這位客人"}
      </button>
      {state && !state.ok && <p className="text-sm text-red-500 mt-2">{state.error}</p>}
    </form>
  );
}
