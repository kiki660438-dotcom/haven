"use client";

import { useFormStatus } from "react-dom";

const DEFAULT_CLASS =
  "bg-primary-dark text-white rounded-lg px-4 py-3 hover:bg-primary transition-colors";

export default function SubmitButton({
  children,
  pendingText = "處理中…",
  className = DEFAULT_CLASS,
}: {
  children: React.ReactNode;
  pendingText?: string;
  className?: string;
}) {
  const { pending } = useFormStatus();
  return (
    <button
      type="submit"
      disabled={pending}
      className={`${className} touch-manipulation active:opacity-80 disabled:opacity-60`}
    >
      {pending ? pendingText : children}
    </button>
  );
}
