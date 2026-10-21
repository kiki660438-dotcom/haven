"use client";

import { useActionState, useMemo, useState } from "react";
import { Search, Pencil, Trash2, Plus, X } from "lucide-react";
import { markOrderPaid } from "../checkout/actions";
import { updateOrder, deleteOrder, type OrderActionState } from "./actions";

export type OrderItem = {
  service_id: string | null;
  service_name: string;
  price: number;
  quantity: number;
  unit_cost: number | null;
};

export type OrderRow = {
  id: string;
  createdLabel: string;
  createdLocal: string;
  total: number;
  status: string;
  paymentMethod: string | null;
  customerName: string;
  phone: string;
  items: OrderItem[];
  cost: number;
};

const field = "border border-primary-light rounded-lg px-2 py-1.5 text-sm focus:outline-none focus:border-primary";

function OrderEditor({ order, onDone }: { order: OrderRow; onDone: () => void }) {
  const [items, setItems] = useState<OrderItem[]>(order.items.map((i) => ({ ...i })));
  const [total, setTotal] = useState(order.total);
  const [method, setMethod] = useState<"cash" | "transfer" | "none">(
    order.paymentMethod === "cash" ? "cash" : order.paymentMethod === "transfer" ? "transfer" : "none"
  );
  const [local, setLocal] = useState(order.createdLocal);

  const [state, formAction, pending] = useActionState<OrderActionState, FormData>(
    async (prev, fd) => {
      const result = await updateOrder(order.id, prev, fd);
      if (result?.ok) onDone();
      return result;
    },
    null
  );

  const itemSum = items.reduce((s, i) => s + i.price * i.quantity, 0);
  const patch = (idx: number, p: Partial<OrderItem>) =>
    setItems((prev) => prev.map((it, i) => (i === idx ? { ...it, ...p } : it)));

  const payload = JSON.stringify({ created_at_local: local, total, payment_method: method, items });

  return (
    <form action={formAction} className="mt-3 pt-3 border-t border-primary-light flex flex-col gap-3">
      <input type="hidden" name="payload" value={payload} />

      <label className="text-xs text-foreground/50">
        日期時間
        <input
          type="datetime-local"
          value={local}
          onChange={(e) => setLocal(e.target.value)}
          required
          className={`${field} block`}
        />
      </label>

      <div className="flex flex-col gap-2">
        <p className="text-xs text-foreground/50">消費項目（單價是折扣後的實際價格）</p>
        {items.map((it, idx) => (
          <div key={idx} className="flex items-center gap-1.5">
            <input
              value={it.service_name}
              onChange={(e) => patch(idx, { service_name: e.target.value })}
              placeholder="項目名稱"
              className={`${field} flex-1 min-w-0`}
            />
            <input
              type="number"
              min={0}
              value={it.price}
              onChange={(e) => patch(idx, { price: Math.max(0, Math.floor(Number(e.target.value) || 0)) })}
              aria-label="單價"
              className={`${field} w-20 text-right`}
            />
            <span className="text-xs text-foreground/40">×</span>
            <input
              type="number"
              min={1}
              value={it.quantity}
              onChange={(e) => patch(idx, { quantity: Math.max(1, Math.floor(Number(e.target.value) || 1)) })}
              aria-label="數量"
              className={`${field} w-12 text-center`}
            />
            <button
              type="button"
              onClick={() => setItems((prev) => prev.filter((_, i) => i !== idx))}
              aria-label="刪除這項"
              className="p-1 text-foreground/40 hover:text-red-500"
            >
              <X size={16} />
            </button>
          </div>
        ))}
        <button
          type="button"
          onClick={() => setItems((prev) => [...prev, { service_id: null, service_name: "", price: 0, quantity: 1, unit_cost: null }])}
          className="self-start inline-flex items-center gap-1 text-xs px-2.5 py-1.5 rounded-lg bg-primary-light text-primary-dark"
        >
          <Plus size={12} /> 加一項
        </button>
      </div>

      <div className="grid grid-cols-2 gap-2">
        <label className="text-xs text-foreground/50">
          實收金額（這筆你實際收到的錢）
          <input
            type="number"
            min={0}
            value={total}
            onChange={(e) => setTotal(Math.max(0, Math.floor(Number(e.target.value) || 0)))}
            className={`${field} block w-full text-right`}
          />
        </label>
        <label className="text-xs text-foreground/50">
          付款方式
          <select
            value={method}
            onChange={(e) => setMethod(e.target.value as "cash" | "transfer" | "none")}
            className={`${field} block w-full bg-white`}
          >
            <option value="cash">現金</option>
            <option value="transfer">匯款</option>
            <option value="none">不收費／無</option>
          </select>
        </label>
      </div>
      {itemSum !== total && (
        <p className="text-xs text-foreground/50">
          項目合計 ${itemSum.toLocaleString()}，實收 ${total.toLocaleString()}（用商品券抵的部分不算在實收裡是正常的）。
        </p>
      )}

      <div className="flex items-center gap-3">
        <button
          type="submit"
          disabled={pending}
          className="bg-primary-dark text-white rounded-lg px-4 py-2 text-sm disabled:opacity-60"
        >
          {pending ? "儲存中…" : "儲存修改"}
        </button>
        <button type="button" onClick={onDone} className="text-sm text-foreground/50 underline">
          取消
        </button>
        {state && !state.ok && <span className="text-sm text-red-500">{state.error}</span>}
      </div>
    </form>
  );
}

export default function OrdersList({ orders }: { orders: OrderRow[] }) {
  const [query, setQuery] = useState("");
  const [editingId, setEditingId] = useState<string | null>(null);
  const [confirmId, setConfirmId] = useState<string | null>(null);

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (!q) return orders;
    return orders.filter(
      (o) =>
        o.customerName.toLowerCase().includes(q) ||
        o.phone.includes(q) ||
        o.items.some((i) => i.service_name.toLowerCase().includes(q))
    );
  }, [orders, query]);

  return (
    <div>
      <div className="relative mb-4 max-w-sm">
        <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-foreground/40" />
        <input
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="搜尋客人姓名、電話或項目"
          className="w-full border border-primary-light rounded-lg pl-9 pr-3 py-2 focus:outline-none focus:border-primary"
        />
      </div>

      <div className="flex flex-col gap-4">
        {filtered.map((o) => {
          const margin = o.total - o.cost;
          return (
            <div key={o.id} className="p-4 border border-primary-light rounded-xl bg-white">
              <div className="flex justify-between items-start mb-2 gap-2">
                <div>
                  <p className="font-semibold">{o.customerName || "現場客"}</p>
                  <p className="text-xs text-foreground/50">{o.createdLabel}</p>
                </div>
                <span
                  className={`text-sm px-2 py-1 rounded-full whitespace-nowrap ${
                    o.status === "paid" ? "bg-primary-light text-primary-dark" : "bg-yellow-100 text-yellow-700"
                  }`}
                >
                  {o.status === "paid"
                    ? `已付款${o.paymentMethod ? `・${o.paymentMethod === "cash" ? "現金" : "匯款"}` : ""}`
                    : "未付款"}
                </span>
              </div>
              <ul className="text-sm text-foreground/70 mb-2">
                {o.items.map((it, idx) => (
                  <li key={idx}>
                    {it.service_name} x{it.quantity} — ${(it.price * it.quantity).toLocaleString()}
                  </li>
                ))}
              </ul>
              <div className="flex justify-between items-center flex-wrap gap-2">
                <div>
                  <p className="font-bold">實收 ${o.total.toLocaleString()}</p>
                  {o.cost > 0 && (
                    <p className="text-xs text-foreground/50">
                      材料成本 ${o.cost.toFixed(1)} ・ 毛利 ${margin.toFixed(1)}
                    </p>
                  )}
                </div>
                <div className="flex flex-wrap items-center gap-2">
                  {o.status !== "paid" && (
                    <>
                      <form action={markOrderPaid.bind(null, o.id, "cash")}>
                        <button className="text-primary-dark text-sm underline">現金付款</button>
                      </form>
                      <form action={markOrderPaid.bind(null, o.id, "transfer")}>
                        <button className="text-primary-dark text-sm underline">匯款付款</button>
                      </form>
                    </>
                  )}
                  <button
                    type="button"
                    onClick={() => {
                      setConfirmId(null);
                      setEditingId(editingId === o.id ? null : o.id);
                    }}
                    className="inline-flex items-center gap-1 text-xs px-2.5 py-1.5 rounded-lg border border-primary-light text-primary-dark hover:bg-primary-light"
                  >
                    <Pencil size={12} /> {editingId === o.id ? "收起" : "編輯"}
                  </button>
                  {confirmId === o.id ? (
                    <form action={deleteOrder.bind(null, o.id)} className="inline-flex items-center gap-1.5">
                      <button
                        type="submit"
                        className="text-xs px-2.5 py-1.5 rounded-lg bg-red-500 text-white"
                      >
                        確定刪除
                      </button>
                      <button type="button" onClick={() => setConfirmId(null)} className="text-xs text-foreground/50 underline">
                        不要
                      </button>
                    </form>
                  ) : (
                    <button
                      type="button"
                      onClick={() => setConfirmId(o.id)}
                      className="inline-flex items-center gap-1 text-xs px-2.5 py-1.5 rounded-lg border border-red-200 text-red-500 hover:bg-red-50"
                    >
                      <Trash2 size={12} /> 刪除
                    </button>
                  )}
                </div>
              </div>
              {confirmId === o.id && (
                <p className="text-xs text-red-500 mt-2">
                  刪除後無法復原。商品券堂數不會自動退還，如果這筆有扣堂或買商品券，請到商品券頁面調整。
                </p>
              )}
              {editingId === o.id && <OrderEditor order={o} onDone={() => setEditingId(null)} />}
            </div>
          );
        })}
        {filtered.length === 0 && <p className="text-center text-foreground/50 py-6">這個月沒有符合的訂單</p>}
      </div>
    </div>
  );
}
