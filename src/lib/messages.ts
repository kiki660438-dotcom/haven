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

export function confirmMessage(name: string, startIso: string) {
  return `親愛的 ${name} 客人您好，\n設計師 KIKI 已經接受您的預約囉！\n\n門店：Haven Hair\n預約時間：${formatTime(startIso)}\n地址：${MAPS_URL}\n\n也可以到預約系統查看您的預約：\n${SITE}/my\n\n服務人員\nKIKI`;
}

// 手機上點這個連結會直接打開簡訊，號碼和內容都已經填好（iPhone、Android 都適用）
export function smsLink(phone: string, body: string) {
  return `sms:${phone}?&body=${encodeURIComponent(body)}`;
}
