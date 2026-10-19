"use client";

import { useState } from "react";
import { ChevronDown, Plus, Trash2 } from "lucide-react";
import { createOrder } from "./actions";
import SubmitButton from "../components/SubmitButton";

export type CheckoutService = { id: string; name: string; price: number; total_sessions: number | null };
export type CheckoutVoucher = {
  id: string;
  service_name: string;
  remaining_sessions: number;
  total_sessions: number;
};

type Line = {
  key: number;
  service_id: string | null;
  name: string;
  price: number;
  qty: number;
  discount: number;
  voucher_id: string | null;
};

// 服務名稱用「主題-細項」命名（例如「冷塑燙-中髮」），依主題分組，只有一種選項的直接顯示
function groupServices(services: CheckoutService[]) {
  const map = new Map<string, CheckoutService[]>();
  for (const s of services) {
    const dashIndex = s.name.indexOf("-");
    const title = dashIndex === -1 ? s.name : s.name.slice(0, dashIndex);
    if (!map.has(title)) map.set(title, []);
    map.get(title)!.push(s);
  }
  return [...map.entries()].map(([title, items]) => ({ title, items }));
}

const num = (v: string) => Math.max(0, Math.floor(Number(v) || 0));
const money = (n: number) => `$${n.toLocaleString()}`;
const inputCls =
  "w-full border border-primary-light rounded-lg px-2 py-1.5 text-sm text-right focus:outline-none focus:border-primary";

export default function CheckoutForm({
  services,
  vouchers,
  staffList,
  appointmentId,
  customerId,
  customerLabel,
  initialServiceIds,
  defaultStaffId,
}: {
  services: CheckoutService[];
  vouchers: CheckoutVoucher[];
  staffList: { id: string; name: string }[];
  appointmentId: string;
  customerId: string;
  customerLabel: string;
  initialServiceIds: string[];
  defaultStaffId: string;
}) {
  const regular = services.filter((s) => !s.total_sessions);
  const packages = services.filter((s) => s.total_sessions);

  // 預約時選的服務自動帶入；預約用的是商品券方案、而且客人有這張券時，直接當作「扣一堂」
  const initialLines: Line[] = [];
  let counter = 0;
  for (const id of initialServiceIds) {
    const s = services.find((x) => x.id === id);
    if (!s) continue;
    if (s.total_sessions) {
      const v = vouchers.find((x) => x.service_name === s.name);
      if (v) {
        initialLines.push({ key: counter++, service_id: s.id, name: s.name, price: 0, qty: 1, discount: 0, voucher_id: v.id });
        continue;
      }
    }
    initialLines.push({ key: counter++, service_id: s.id, name: s.name, price: s.price, qty: 1, discount: 0, voucher_id: null });
  }

  const [lines, setLines] = useState<Line[]>(initialLines);
  const [nextKey, setNextKey] = useState(counter);
  const [customName, setCustomName] = useState("");
  const [customPrice, setCustomPrice] = useState("");
  const [walkInName, setWalkInName] = useState("");
  const [staffId, setStaffId] = useState(defaultStaffId);
  const [payTouched, setPayTouched] = useState(false);
  const [cashInput, setCashInput] = useState(0);
  const [transferInput, setTransferInput] = useState(0);

  const lineTotal = (l: Line) => (l.voucher_id ? 0 : Math.max(0, l.price * l.qty - l.discount));
  const payable = lines.reduce((sum, l) => sum + lineTotal(l), 0);
  const subtotal = lines.reduce((sum, l) => sum + (l.voucher_id ? 0 : l.price * l.qty), 0);
  const discountTotal = lines.reduce((sum, l) => sum + (l.voucher_id ? 0 : Math.min(l.discount, l.price * l.qty)), 0);

  const cash = payTouched ? cashInput : payable;
  const transfer = payTouched ? transferInput : 0;
  const payMismatch = cash + transfer !== payable;
  const needsCustomer = lines.some((l) => l.service_id && services.find((s) => s.id === l.service_id)?.total_sessions && !l.voucher_id);
  const missingCustomer = needsCustomer && !customerId;
  const canSubmit = lines.length > 0 && !payMismatch && !missingCustomer;

  const addLine = (partial: Omit<Line, "key">) => {
    setLines((prev) => [...prev, { ...partial, key: nextKey }]);
    setNextKey((k) => k + 1);
  };
  const updateLine = (key: number, patch: Partial<Line>) =>
    setLines((prev) => prev.map((l) => (l.key === key ? { ...l, ...patch } : l)));
  const removeLine = (key: number) => setLines((prev) => prev.filter((l) => l.key !== key));

  const addService = (s: CheckoutService) =>
    addLine({ service_id: s.id, name: s.name, price: s.price, qty: 1, discount: 0, voucher_id: null });

  const addCustom = () => {
    const name = customName.trim();
    if (!name) return;
    addLine({ service_id: null, name, price: num(customPrice), qty: 1, discount: 0, voucher_id: null });
    setCustomName("");
    setCustomPrice("");
  };

  const usedOf = (voucherId: string) => lines.filter((l) => l.voucher_id === voucherId).length;

  const payload = JSON.stringify({
    appointment_id: appointmentId || null,
    customer_id: customerId || null,
    customer_name: customerId ? null : walkInName.trim() || null,
    staff_id: staffId || null,
    cash,
    transfer,
    lines: lines.map((l) => ({
      service_id: l.service_id,
      name: l.name,
      price: l.price,
      qty: l.qty,
      discount: l.discount,
      voucher_id: l.voucher_id,
    })),
  });

  const regularGroups = groupServices(regular);
  const singles = regularGroups.filter((g) => g.items.length === 1);
  const multis = regularGroups.filter((g) => g.items.length > 1);

  return (
    <form action={createOrder} className="flex flex-col gap-5">
      <input type="hidden" name="payload" value={payload} />

      <section className="p-4 border border-primary-light rounded-xl bg-white">
        <p className="text-sm text-foreground/60 mb-1">客人</p>
        {customerId ? (
          <p className="font-semibold">{customerLabel}</p>
        ) : (
          <input
            value={walkInName}
            onChange={(e) => setWalkInName(e.target.value)}
            placeholder="現場客（可填姓名，不填就是散客）"
            className="w-full border border-primary-light rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-primary"
          />
        )}
      </section>

      <section className="p-4 border border-primary-light rounded-xl bg-white flex flex-col gap-3">
        <p className="font-semibold">消費項目</p>
        {lines.length === 0 && <p className="text-sm text-foreground/50">還沒有項目，請從下面點選加入。</p>}

        {lines.map((l) => (
          <div key={l.key} className="rounded-lg border border-primary-light p-3 flex flex-col gap-2">
            <div className="flex items-start justify-between gap-2">
              <p className="font-medium text-sm">
                {l.name}
                {l.voucher_id && (
                  <span className="ml-2 text-xs px-2 py-0.5 rounded-full bg-primary-light text-primary-dark">
                    商品券扣一堂・不收費
                  </span>
                )}
              </p>
              <button
                type="button"
                onClick={() => removeLine(l.key)}
                aria-label="刪除這項"
                className="p-1 text-foreground/40 hover:text-red-500"
              >
                <Trash2 size={16} />
              </button>
            </div>

            {!l.voucher_id && (
              <>
                <div className="grid grid-cols-3 gap-2 text-xs text-foreground/50">
                  <label>
                    單價
                    <input
                      type="number"
                      min={0}
                      value={l.price}
                      onChange={(e) => updateLine(l.key, { price: num(e.target.value) })}
                      className={inputCls}
                    />
                  </label>
                  <label>
                    數量
                    <input
                      type="number"
                      min={1}
                      max={20}
                      value={l.qty}
                      onChange={(e) => updateLine(l.key, { qty: Math.min(20, Math.max(1, num(e.target.value))) })}
                      className={inputCls}
                    />
                  </label>
                  <label>
                    折扣金額
                    <input
                      type="number"
                      min={0}
                      value={l.discount}
                      onChange={(e) => updateLine(l.key, { discount: num(e.target.value) })}
                      className={inputCls}
                    />
                  </label>
                </div>
                <div className="flex items-center justify-between text-xs">
                  <span className="flex gap-1.5">
                    <button
                      type="button"
                      onClick={() => updateLine(l.key, { discount: Math.round(l.price * l.qty * 0.2) })}
                      className="px-2 py-1 rounded-full bg-primary-light text-primary-dark"
                    >
                      8折
                    </button>
                    <button
                      type="button"
                      onClick={() => updateLine(l.key, { discount: Math.round(l.price * l.qty * 0.1) })}
                      className="px-2 py-1 rounded-full bg-primary-light text-primary-dark"
                    >
                      9折
                    </button>
                    <button
                      type="button"
                      onClick={() => updateLine(l.key, { discount: 0 })}
                      className="px-2 py-1 rounded-full bg-gray-100 text-foreground/60"
                    >
                      無折扣
                    </button>
                  </span>
                  <span className="text-sm font-semibold">{money(lineTotal(l))}</span>
                </div>
              </>
            )}
          </div>
        ))}
      </section>

      <section className="p-4 border border-primary-light rounded-xl bg-white flex flex-col gap-4">
        <p className="font-semibold">加入項目</p>

        {vouchers.length > 0 && (
          <div>
            <p className="text-xs text-foreground/50 mb-1">客人的商品券（點「扣一堂」，不收費）</p>
            <div className="flex flex-col gap-1.5">
              {vouchers.map((v) => {
                const left = v.remaining_sessions - usedOf(v.id);
                return (
                  <div
                    key={v.id}
                    className="flex items-center justify-between gap-2 rounded-lg bg-primary-light/50 px-3 py-2 text-sm"
                  >
                    <span>
                      {v.service_name}
                      <span className="text-xs text-foreground/50">　剩 {left} / {v.total_sessions} 堂</span>
                    </span>
                    <button
                      type="button"
                      disabled={left <= 0}
                      onClick={() =>
                        addLine({
                          service_id: services.find((s) => s.name === v.service_name)?.id ?? null,
                          name: v.service_name,
                          price: 0,
                          qty: 1,
                          discount: 0,
                          voucher_id: v.id,
                        })
                      }
                      className="shrink-0 px-3 py-1 rounded-lg bg-primary-dark text-white text-xs disabled:opacity-30"
                    >
                      扣一堂
                    </button>
                  </div>
                );
              })}
            </div>
          </div>
        )}

        <div>
          <p className="text-xs text-foreground/50 mb-1">服務項目（點一下加入）</p>
          <div className="flex flex-col gap-1 max-h-72 overflow-y-auto border border-primary-light rounded-lg p-2">
            {singles.map((g) => {
              const s = g.items[0];
              return (
                <button
                  type="button"
                  key={s.id}
                  onClick={() => addService(s)}
                  className="flex items-center justify-between gap-2 px-2 py-1.5 rounded-lg text-sm text-left hover:bg-primary-light"
                >
                  <span>{s.name}</span>
                  <span className="text-foreground/50 text-xs">{money(s.price)}</span>
                </button>
              );
            })}
            {singles.length > 0 && multis.length > 0 && <hr className="border-primary-light my-1" />}
            {multis.map((g) => (
              <details key={g.title} className="group">
                <summary className="flex items-center justify-between gap-2 px-2 py-1.5 rounded-lg text-sm cursor-pointer select-none hover:bg-primary-light">
                  {g.title}
                  <ChevronDown size={14} className="text-foreground/40 transition-transform group-open:rotate-180" />
                </summary>
                <div className="flex flex-col gap-1 pl-4 mt-1">
                  {g.items.map((s) => (
                    <button
                      type="button"
                      key={s.id}
                      onClick={() => addService(s)}
                      className="flex items-center justify-between gap-2 px-2 py-1.5 rounded-lg text-sm text-left hover:bg-primary-light"
                    >
                      <span>{s.name.slice(g.title.length + 1)}</span>
                      <span className="text-foreground/50 text-xs">{money(s.price)}</span>
                    </button>
                  ))}
                </div>
              </details>
            ))}
          </div>
        </div>

        {packages.length > 0 && (
          <details className="group">
            <summary className="flex items-center justify-between gap-2 text-sm cursor-pointer select-none">
              購買商品券方案（會收費並開新的商品券，需要選擇會員）
              <ChevronDown size={14} className="text-foreground/40 transition-transform group-open:rotate-180" />
            </summary>
            <div className="flex flex-col gap-1 mt-2 max-h-60 overflow-y-auto border border-primary-light rounded-lg p-2">
              {packages.map((s) => (
                <button
                  type="button"
                  key={s.id}
                  onClick={() => addService(s)}
                  className="flex items-center justify-between gap-2 px-2 py-1.5 rounded-lg text-sm text-left hover:bg-primary-light"
                >
                  <span>
                    {s.name}
                    <span className="text-xs text-foreground/40">　{s.total_sessions} 堂</span>
                  </span>
                  <span className="text-foreground/50 text-xs">{money(s.price)}</span>
                </button>
              ))}
            </div>
          </details>
        )}

        <div>
          <p className="text-xs text-foreground/50 mb-1">自訂項目（例如「依現場報價」的項目）</p>
          <div className="flex gap-2">
            <input
              value={customName}
              onChange={(e) => setCustomName(e.target.value)}
              placeholder="項目名稱"
              className="flex-1 min-w-0 border border-primary-light rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-primary"
            />
            <input
              type="number"
              min={0}
              value={customPrice}
              onChange={(e) => setCustomPrice(e.target.value)}
              placeholder="金額"
              className="w-24 border border-primary-light rounded-lg px-2 py-2 text-sm text-right focus:outline-none focus:border-primary"
            />
            <button
              type="button"
              onClick={addCustom}
              className="shrink-0 inline-flex items-center gap-1 px-3 rounded-lg bg-primary-light text-primary-dark text-sm"
            >
              <Plus size={14} /> 加入
            </button>
          </div>
        </div>
      </section>

      <section className="p-4 border border-primary-light rounded-xl bg-white flex flex-col gap-3">
        <p className="font-semibold">結帳</p>
        <div className="text-sm flex flex-col gap-1">
          <div className="flex justify-between text-foreground/60">
            <span>小計</span>
            <span>{money(subtotal)}</span>
          </div>
          {discountTotal > 0 && (
            <div className="flex justify-between text-foreground/60">
              <span>折扣</span>
              <span>-{money(discountTotal)}</span>
            </div>
          )}
          <div className="flex justify-between font-bold text-base">
            <span>應收（現場付款）</span>
            <span>{money(payable)}</span>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-2 text-xs text-foreground/50">
          <label>
            現金
            <input
              type="number"
              min={0}
              value={cash}
              onChange={(e) => {
                setPayTouched(true);
                setCashInput(num(e.target.value));
                setTransferInput(transfer);
              }}
              className={inputCls}
            />
          </label>
          <label>
            匯款
            <input
              type="number"
              min={0}
              value={transfer}
              onChange={(e) => {
                setPayTouched(true);
                setTransferInput(num(e.target.value));
                setCashInput(cash);
              }}
              className={inputCls}
            />
          </label>
        </div>
        <div className="flex gap-2 text-xs">
          <button
            type="button"
            onClick={() => {
              setPayTouched(true);
              setCashInput(payable);
              setTransferInput(0);
            }}
            className="px-3 py-1 rounded-full bg-primary-light text-primary-dark"
          >
            全收現金
          </button>
          <button
            type="button"
            onClick={() => {
              setPayTouched(true);
              setCashInput(0);
              setTransferInput(payable);
            }}
            className="px-3 py-1 rounded-full bg-primary-light text-primary-dark"
          >
            全收匯款
          </button>
        </div>
        {payMismatch && (
          <p className="text-sm text-red-500">
            現金＋匯款（{money(cash + transfer)}）要等於應收（{money(payable)}）。
          </p>
        )}
        {missingCustomer && (
          <p className="text-sm text-red-500">購買商品券方案需要先選擇會員，才能開立商品券。</p>
        )}

        <label className="text-xs text-foreground/50">
          服務人員（業績歸屬）
          <select
            value={staffId}
            onChange={(e) => setStaffId(e.target.value)}
            className="w-full border border-primary-light rounded-lg px-3 py-2 text-sm text-foreground bg-white focus:outline-none focus:border-primary"
          >
            <option value="">未指定</option>
            {staffList.map((s) => (
              <option key={s.id} value={s.id}>
                {s.name}
              </option>
            ))}
          </select>
        </label>

        {canSubmit ? (
          <SubmitButton pendingText="建立中…">建立訂單</SubmitButton>
        ) : (
          <button
            type="button"
            disabled
            className="bg-primary-dark text-white rounded-lg px-4 py-3 opacity-40"
          >
            建立訂單
          </button>
        )}
      </section>
    </form>
  );
}
