"use client";

import { useActionState } from "react";
import { updateAppointmentTime, type UpdateTimeState } from "./actions";

export default function UpdateTimeForm({
  appointmentId,
  defaultDate,
  defaultTime,
  defaultBufferHours,
  defaultBufferMinutes,
}: {
  appointmentId: string;
  defaultDate: string;
  defaultTime: string;
  defaultBufferHours: number;
  defaultBufferMinutes: number;
}) {
  const [state, formAction, pending] = useActionState<UpdateTimeState, FormData>(
    updateAppointmentTime.bind(null, appointmentId),
    null
  );

  return (
    <form action={formAction} className="flex flex-wrap items-center gap-2 mt-2 pl-4">
      <input
        type="date"
        name="date"
        defaultValue={defaultDate}
        className="border border-primary-light rounded-lg px-2 py-1 text-sm"
      />
      <input
        type="time"
        name="time"
        defaultValue={defaultTime}
        className="border border-primary-light rounded-lg px-2 py-1 text-sm"
      />
      <span className="text-xs text-foreground/50 whitespace-nowrap">緩衝</span>
      <input
        type="number"
        name="buffer_hours"
        min={0}
        defaultValue={defaultBufferHours}
        className="w-12 border border-primary-light rounded-lg px-2 py-1 text-sm"
      />
      <span className="text-xs text-foreground/50">時</span>
      <input
        type="number"
        name="buffer_minutes"
        min={0}
        max={59}
        defaultValue={defaultBufferMinutes}
        className="w-12 border border-primary-light rounded-lg px-2 py-1 text-sm"
      />
      <span className="text-xs text-foreground/50">分</span>
      <button
        type="submit"
        disabled={pending}
        className="text-primary-dark text-sm underline whitespace-nowrap disabled:opacity-50"
      >
        {pending ? "更新中…" : "更新"}
      </button>
      {state?.ok && <span className="text-xs text-primary-dark">✓ 已更新</span>}
      {state && !state.ok && <span className="text-xs text-red-500">{state.error}</span>}
    </form>
  );
}
