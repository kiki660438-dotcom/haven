import Link from "next/link";
import { cookies } from "next/headers";
import { LINE_PENDING_COOKIE, verifyLinePending } from "@/lib/customer-identity";
import SubmitButton from "../components/SubmitButton";
import { linkLineByPhone, skipLineLink } from "./actions";

const ERRORS: Record<string, string> = {
  phone: "電話號碼格式不對，請輸入 09 開頭的 10 碼手機號碼。",
  bound: "這支電話已經綁定其他 LINE 帳號了，請直接聯絡店家幫您處理。",
  failed: "連結失敗，請再試一次，或直接聯絡店家。",
  expired: "登入已經過期，請回到預約頁重新用 LINE 登入。",
};

export default async function LineLinkPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string }>;
}) {
  const { error } = await searchParams;
  const cookieStore = await cookies();
  const pending = verifyLinePending(cookieStore.get(LINE_PENDING_COOKIE)?.value);

  if (!pending) {
    return (
      <main className="max-w-md mx-auto p-8">
        <p className="mb-4 text-foreground/70">{ERRORS.expired}</p>
        <Link href="/book" className="underline text-primary-dark">
          回到預約頁
        </Link>
      </main>
    );
  }

  return (
    <main className="max-w-md mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-2">哈囉，{pending.displayName}！</h1>
      <p className="text-sm text-foreground/70 mb-6">
        第一次用 LINE 登入，請輸入您的手機號碼。如果您之前來過 Haven，系統會把這個 LINE
        連結到您原本的會員資料（商品券、消費紀錄都會在）。只需要做一次。
      </p>

      {error && ERRORS[error] && (
        <div className="mb-4 p-3 rounded-xl bg-red-50 text-red-600 text-sm">{ERRORS[error]}</div>
      )}

      <form action={linkLineByPhone} className="flex flex-col gap-3 p-5 border border-primary-light rounded-xl bg-white">
        <input
          name="phone"
          type="tel"
          inputMode="tel"
          autoComplete="tel"
          required
          placeholder="手機號碼，例如 0912345678"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <SubmitButton pendingText="連結中…">確認</SubmitButton>
      </form>

      <form action={skipLineLink} className="mt-6 text-center">
        <button type="submit" className="text-sm text-foreground/50 underline">
          沒有台灣手機號碼？略過這一步
        </button>
      </form>
    </main>
  );
}
