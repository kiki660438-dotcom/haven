// 台北時間的「現在」
function taipeiNow(now = new Date()) {
  const parts = new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Taipei",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    hourCycle: "h23",
  }).formatToParts(now);
  const get = (t: string) => Number(parts.find((p) => p.type === t)?.value);
  return { y: get("year"), m: get("month"), d: get("day"), h: get("hour") };
}

function lastDayOfMonth(y: number, m: number) {
  // m 是 1~12；Date.UTC 的月份從 0 開始，所以傳 m 剛好是「下個月」，日期 0 = 本月最後一天
  return new Date(Date.UTC(y, m, 0)).toISOString().slice(0, 10);
}

// 每月固定在 day 號 hour 點開放「下個月整個月」：
// 還沒到開放時間 → 只開到本月底；到了（含當天那個小時）→ 開到下個月底
export function monthlyOpenMaxDate(day: number, hour: number, now = new Date()) {
  const { y, m, d, h } = taipeiNow(now);
  const opened = d > day || (d === day && h >= hour);
  return lastDayOfMonth(y, opened ? m + 1 : m);
}

// 設定值格式 "15:20"（每月 15 號 20 點）；格式不對就當作沒設定
export function parseMonthlyOpen(value: string | undefined | null) {
  const m = /^(\d{1,2}):(\d{1,2})$/.exec((value ?? "").trim());
  if (!m) return null;
  const day = Number(m[1]);
  const hour = Number(m[2]);
  if (day < 1 || day > 28 || hour < 0 || hour > 23) return null;
  return { day, hour };
}

// 客人最早能約的日期（不接受當日預約）：台北時間的明天
export function earliestBookingDate(now = new Date()) {
  const { y, m, d } = taipeiNow(now);
  return new Date(Date.UTC(y, m - 1, d) + 86_400_000).toISOString().slice(0, 10);
}

// 預約人數限制在 1~5 位
export function clampPartySize(raw: unknown) {
  const n = Math.floor(Number(raw));
  return Number.isFinite(n) ? Math.min(Math.max(n, 1), 5) : 1;
}
