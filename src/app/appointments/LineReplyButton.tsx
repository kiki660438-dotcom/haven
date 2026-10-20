"use client";

import { useState } from "react";
import { MessageCircle } from "lucide-react";

export default function LineReplyButton({ chatUrl, text }: { chatUrl: string; text: string }) {
  const [copied, setCopied] = useState(false);

  return (
    <button
      type="button"
      onClick={async () => {
        try {
          await navigator.clipboard.writeText(text);
          setCopied(true);
          setTimeout(() => setCopied(false), 4000);
        } catch {
          window.prompt("請手動複製下面的訊息，再到聊天室貼上", text);
        }
        window.open(chatUrl, "_blank", "noopener");
      }}
      className="inline-flex items-center gap-1 text-sm px-3 py-1.5 rounded-lg border border-green-200 text-green-700 hover:bg-green-50 transition-colors"
    >
      <MessageCircle size={14} />
      {copied ? "已複製訊息，到聊天室貼上" : "回覆 LINE 預約成功"}
    </button>
  );
}
