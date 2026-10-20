"use client";

import { useState } from "react";
import { MessageCircle, Copy } from "lucide-react";

export default function LineReplyButton({
  chatUrl,
  text,
  nickname,
}: {
  chatUrl: string;
  text: string;
  nickname: string | null;
}) {
  const [state, setState] = useState<"idle" | "message" | "nickname">("idle");

  const copy = async (value: string) => {
    try {
      await navigator.clipboard.writeText(value);
      return true;
    } catch {
      window.prompt("請手動複製", value);
      return false;
    }
  };

  return (
    <span className="inline-flex flex-wrap items-center gap-2">
      <button
        type="button"
        onClick={async () => {
          await copy(text);
          setState("message");
          window.open(chatUrl, "_blank", "noopener");
        }}
        className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-green-200 text-green-700 hover:bg-green-50 transition-colors"
      >
        <MessageCircle size={14} />
        {state === "message" ? "已複製訊息，到聊天室貼上" : "回覆 LINE 預約成功"}
      </button>
      {nickname && (
        <button
          type="button"
          onClick={async () => {
            await copy(nickname);
            setState("nickname");
          }}
          title="聊天室沒有直接打開這位客人時，把暱稱貼到搜尋欄"
          className="inline-flex items-center gap-1 text-xs px-2.5 py-1.5 rounded-lg border border-primary-light text-foreground/60 hover:bg-primary-light transition-colors"
        >
          <Copy size={12} />
          {state === "nickname" ? "已複製暱稱，貼到聊天室搜尋" : "複製 LINE 暱稱"}
        </button>
      )}
    </span>
  );
}
