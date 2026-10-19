"use client";

import { useState } from "react";
import { Copy, Check } from "lucide-react";

const MAPS_URL = "https://maps.app.goo.gl/rkyQPMQHHDYaGvRr5";
const SITE = "https://haven-flax.vercel.app";

function formatTime(iso: string) {
  const parts = new Intl.DateTimeFormat("zh-TW", {
    timeZone: "Asia/Taipei",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    hourCycle: "h23",
  }).formatToParts(new Date(iso));
  const p = (t: string) => parts.find((x) => x.type === t)?.value ?? "";
  return `${p("year")}/${p("month")}/${p("day")} ${p("hour")}:${p("minute")}`;
}

export default function CopyMessageButton({
  kind,
  name,
  startIso,
}: {
  kind: "confirm" | "decline";
  name: string;
  startIso: string;
}) {
  const [copied, setCopied] = useState(false);
  const time = formatTime(startIso);

  const text =
    kind === "confirm"
      ? `親愛的 ${name} 客人您好，\n設計師 KIKI 已經接受您的預約囉！\n\n門店：Haven Hair\n預約時間：${time}\n地址：${MAPS_URL}\n\n也可以到預約系統查看您的預約：\n${SITE}/my\n\n服務人員\nKIKI`
      : `親愛的 ${name} 客人您好，\n您 ${time} 的預約，設計師 KIKI 該時段已有其他客人，暫時無法接受您的預約，再請您改約其他時間，謝謝！\n\n可以到預約系統重新選擇時間：\n${SITE}/book`;

  return (
    <button
      type="button"
      onClick={async () => {
        try {
          await navigator.clipboard.writeText(text);
          setCopied(true);
          setTimeout(() => setCopied(false), 2000);
        } catch {
          window.prompt("請手動複製下面的訊息", text);
        }
      }}
      className="inline-flex items-center gap-1 text-xs px-2.5 py-1.5 rounded-lg border border-primary-light text-foreground/60 hover:bg-primary-light transition-colors"
    >
      {copied ? <Check size={12} /> : <Copy size={12} />}
      {copied ? "已複製" : kind === "confirm" ? "複製確認訊息" : "複製婉拒訊息"}
    </button>
  );
}
