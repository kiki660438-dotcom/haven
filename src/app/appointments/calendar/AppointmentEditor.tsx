"use client";

import { useActionState, useState } from "react";
import { ChevronDown } from "lucide-react";
import { updateAppointmentDetails, type UpdateDetailsState } from "../actions";

export type ServiceOption = { id: string; name: string; price: number; total_sessions: number | null };

function groupServices(services: ServiceOption[]) {
  const map = new Map<string, ServiceOption[]>();
  for (const s of services) {
    const dashIndex = s.name.indexOf("-");
    const title = dashIndex === -1 ? s.name : s.name.slice(0, dashIndex);
    if (!map.has(title)) map.set(title, []);
    map.get(title)!.push(s);
  }
  return [...map.entries()].map(([title, items]) => ({ title, items }));
}

const field = "border border-primary-light rounded-lg px-2 py-1.5 text-sm focus:outline-none focus:border-primary";

export default function AppointmentEditor({
  appointmentId,
  dateKey,
  time,
  bufferMinutes,
  serviceIds,
  note,
  services,
  onSaved,
}: {
  appointmentId: string;
  dateKey: string;
  time: string;
  bufferMinutes: number;
  serviceIds: string[];
  note: string | null;
  services: ServiceOption[];
  onSaved?: () => void;
}) {
  const [state, formAction, pending] = useActionState<UpdateDetailsState, FormData>(
    async (prev, formData) => {
      const result = await updateAppointmentDetails(appointmentId, prev, formData);
      if (result?.ok) onSaved?.();
      return result;
    },
    null
  );
  const [selected, setSelected] = useState<Set<string>>(new Set(serviceIds));

  const toggle = (id: string) =>
    setSelected((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });

  const regular = services.filter((s) => !s.total_sessions);
  const packages = services.filter((s) => s.total_sessions);
  const groups = groupServices(regular);
  const singles = groups.filter((g) => g.items.length === 1);
  const multis = groups.filter((g) => g.items.length > 1);

  const Item = ({ s, label }: { s: ServiceOption; label: string }) => (
    <label className="flex items-center gap-2 px-2 py-1.5 rounded-lg text-sm cursor-pointer hover:bg-primary-light">
      <input type="checkbox" checked={selected.has(s.id)} onChange={() => toggle(s.id)} />
      {label}
    </label>
  );

  return (
    <form action={formAction} className="mt-3 pt-3 border-t border-primary-light flex flex-col gap-3">
      {[...selected].map((id) => (
        <input key={id} type="hidden" name="service_id" value={id} />
      ))}

      <div className="flex flex-wrap gap-2">
        <label className="text-xs text-foreground/50">
          日期
          <input type="date" name="date" defaultValue={dateKey} required className={`${field} block`} />
        </label>
        <label className="text-xs text-foreground/50">
          時間
          <input type="time" name="time" defaultValue={time} required className={`${field} block`} />
        </label>
      </div>

      <div>
        <p className="text-xs text-foreground/50 mb-1">服務項目（已選 {selected.size} 項）</p>
        <div className="flex flex-col gap-0.5 max-h-56 overflow-y-auto border border-primary-light rounded-lg p-1.5">
          {singles.map((g) => (
            <Item key={g.items[0].id} s={g.items[0]} label={`${g.items[0].name}（$${g.items[0].price}）`} />
          ))}
          {multis.map((g) => (
            <details key={g.title} open={g.items.some((s) => selected.has(s.id))} className="group">
              <summary className="flex items-center justify-between px-2 py-1.5 rounded-lg text-sm cursor-pointer select-none hover:bg-primary-light">
                {g.title}
                <ChevronDown size={14} className="text-foreground/40 transition-transform group-open:rotate-180" />
              </summary>
              <div className="pl-3">
                {g.items.map((s) => (
                  <Item key={s.id} s={s} label={`${s.name.slice(g.title.length + 1)}（$${s.price}）`} />
                ))}
              </div>
            </details>
          ))}
          {packages.length > 0 && (
            <details open={packages.some((s) => selected.has(s.id))} className="group">
              <summary className="flex items-center justify-between px-2 py-1.5 rounded-lg text-sm cursor-pointer select-none hover:bg-primary-light">
                商品券方案（用商品券預約選這裡）
                <ChevronDown size={14} className="text-foreground/40 transition-transform group-open:rotate-180" />
              </summary>
              <div className="pl-3">
                {packages.map((s) => (
                  <Item key={s.id} s={s} label={s.name} />
                ))}
              </div>
            </details>
          )}
        </div>
      </div>

      <div className="flex items-end gap-2">
        <span className="text-xs text-foreground/50 pb-2">緩衝</span>
        <input
          type="number"
          name="buffer_hours"
          min={0}
          defaultValue={Math.floor(bufferMinutes / 60)}
          className={`${field} w-16`}
        />
        <span className="text-xs text-foreground/50 pb-2">時</span>
        <input
          type="number"
          name="buffer_minutes"
          min={0}
          max={59}
          defaultValue={bufferMinutes % 60}
          className={`${field} w-16`}
        />
        <span className="text-xs text-foreground/50 pb-2">分</span>
      </div>

      <label className="text-xs text-foreground/50">
        備註
        <textarea name="note" rows={2} defaultValue={note ?? ""} className={`${field} block w-full`} />
      </label>

      <div className="flex items-center gap-3">
        <button
          type="submit"
          disabled={pending}
          className="bg-primary-dark text-white rounded-lg px-4 py-2 text-sm disabled:opacity-60"
        >
          {pending ? "儲存中…" : "儲存修改"}
        </button>
        {state?.ok && <span className="text-sm text-primary-dark">已儲存 ✓</span>}
        {state && !state.ok && <span className="text-sm text-red-500">{state.error}</span>}
      </div>
    </form>
  );
}
