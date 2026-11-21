// 接受 0912345678、912345678、+886912345678、886912345678 這幾種寫法，統一轉成 09 開頭的 10 碼
export function normalizePhone(text: string) {
  let digits = text.replace(/[^0-9]/g, "");
  if (digits.startsWith("886") && digits.length === 12) digits = "0" + digits.slice(3);
  else if (/^9\d{8}$/.test(digits)) digits = "0" + digits;
  return /^09\d{8}$/.test(digits) ? digits : null;
}
