"use client";

import { useState } from "react";
import { MessageCircle, Copy } from "lucide-react";

export default function LineReplyButton({ text, nickname }: { text: string; nickname: string | null }) {
  const [state, setState] = useState<"idle" | "message" | "nickname">("idle");

  const copy = async (value: string) => {
    try {
      await navigator.clipboard.writeText(value);
    } catch {
      window.prompt("請手動複製", value);
    }
  };

  return (
    <span className="inline-flex flex-wrap items-center gap-2">
      {nickname && (
        <button
          type="button"
          onClick={async () => {
            await copy(nickname);
            setState("nickname");
          }}
          className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-green-200 text-green-700 hover:bg-green-50 transition-colors"
        >
          <Copy size={14} />
          {state === "nickname" ? "已複製暱稱，貼到 LINE 搜尋" : "複製 LINE 暱稱"}
        </button>
      )}
      <button
        type="button"
        onClick={async () => {
          await copy(text);
          setState("message");
        }}
        className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-green-200 text-green-700 hover:bg-green-50 transition-colors"
      >
        <MessageCircle size={14} />
        {state === "message" ? "已複製訊息，到聊天室貼上" : "複製預約成功訊息"}
      </button>
    </span>
  );
}
