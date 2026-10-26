"use client";

import { useActionState, useRef, useState } from "react";
import { Pencil, Trash2 } from "lucide-react";
import {
  addCustomerRecord,
  updateCustomerRecord,
  deleteCustomerRecord,
  type RecordState,
} from "./actions";

export type RecordRow = { id: string; visitDate: string; content: string };

const field = "border border-primary-light rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-primary";

function AddForm({ customerId, today }: { customerId: string; today: string }) {
  const formRef = useRef<HTMLFormElement>(null);
  const [state, formAction, pending] = useActionState<RecordState, FormData>(async (prev, fd) => {
    const result = await addCustomerRecord(customerId, prev, fd);
    if (result?.ok) formRef.current?.reset();
    return result;
  }, null);

  return (
    <form
      ref={formRef}
      action={formAction}
      className="p-4 border border-primary-light rounded-xl bg-white flex flex-col gap-3 mb-4"
    >
      <p className="font-semibold text-sm">新增紀錄</p>
      <label className="text-xs text-foreground/50">
        日期
        <input type="date" name="visit_date" defaultValue={today} required className={`${field} block`} />
      </label>
      <label className="text-xs text-foreground/50">
        內容（例如染髮配方、髮質狀況、注意事項）
        <textarea
          name="content"
          rows={5}
          required
          placeholder={"例如：\n染髮：7/0 + 6/1 = 1:1，雙氧 6% 1:1.5，停留 35 分鐘\n髮根補染，髮尾有點乾，下次加護髮"}
          className={`${field} block w-full`}
        />
      </label>
      <div className="flex items-center gap-3">
        <button
          type="submit"
          disabled={pending}
          className="bg-primary-dark text-white rounded-lg px-4 py-2 text-sm disabled:opacity-60"
        >
          {pending ? "儲存中…" : "儲存紀錄"}
        </button>
        {state?.ok && <span className="text-sm text-primary-dark">已儲存 ✓</span>}
        {state && !state.ok && <span className="text-sm text-red-500">{state.error}</span>}
      </div>
    </form>
  );
}

function RecordItem({ record, customerId }: { record: RecordRow; customerId: string }) {
  const [editing, setEditing] = useState(false);
  const [confirming, setConfirming] = useState(false);
  const [state, formAction, pending] = useActionState<RecordState, FormData>(async (prev, fd) => {
    const result = await updateCustomerRecord(record.id, customerId, prev, fd);
    if (result?.ok) setEditing(false);
    return result;
  }, null);

  return (
    <div className="p-4 border border-primary-light rounded-xl bg-white">
      <div className="flex items-start justify-between gap-2 mb-1">
        <p className="font-semibold text-primary-dark">{record.visitDate.replaceAll("-", "/")}</p>
        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={() => {
              setConfirming(false);
              setEditing(!editing);
            }}
            className="inline-flex items-center gap-1 text-xs px-2.5 py-1.5 rounded-lg border border-primary-light text-primary-dark hover:bg-primary-light"
          >
            <Pencil size={12} /> {editing ? "收起" : "編輯"}
          </button>
          {confirming ? (
            <form action={deleteCustomerRecord.bind(null, record.id, customerId)} className="inline-flex items-center gap-1.5">
              <button type="submit" className="text-xs px-2.5 py-1.5 rounded-lg bg-red-500 text-white">
                確定刪除
              </button>
              <button type="button" onClick={() => setConfirming(false)} className="text-xs text-foreground/50 underline">
                不要
              </button>
            </form>
          ) : (
            <button
              type="button"
              onClick={() => setConfirming(true)}
              className="inline-flex items-center gap-1 text-xs px-2.5 py-1.5 rounded-lg border border-red-200 text-red-500 hover:bg-red-50"
            >
              <Trash2 size={12} /> 刪除
            </button>
          )}
        </div>
      </div>

      {editing ? (
        <form action={formAction} className="flex flex-col gap-2 mt-2">
          <input type="date" name="visit_date" defaultValue={record.visitDate} required className={`${field} w-44`} />
          <textarea name="content" rows={5} required defaultValue={record.content} className={`${field} w-full`} />
          <div className="flex items-center gap-3">
            <button
              type="submit"
              disabled={pending}
              className="bg-primary-dark text-white rounded-lg px-4 py-2 text-sm disabled:opacity-60"
            >
              {pending ? "儲存中…" : "儲存修改"}
            </button>
            {state && !state.ok && <span className="text-sm text-red-500">{state.error}</span>}
          </div>
        </form>
      ) : (
        <p className="text-sm whitespace-pre-wrap break-words">{record.content}</p>
      )}
    </div>
  );
}

export default function RecordsPanel({
  customerId,
  today,
  records,
}: {
  customerId: string;
  today: string;
  records: RecordRow[];
}) {
  return (
    <div>
      <AddForm customerId={customerId} today={today} />
      <div className="flex flex-col gap-3">
        {records.map((r) => (
          <RecordItem key={r.id} record={r} customerId={customerId} />
        ))}
        {records.length === 0 && <p className="text-center text-foreground/50 py-6">還沒有紀錄</p>}
      </div>
    </div>
  );
}
