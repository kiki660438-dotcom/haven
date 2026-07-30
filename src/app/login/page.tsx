import { login } from "./actions";

export default async function LoginPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string }>;
}) {
  const { error } = await searchParams;

  return (
    <main className="max-w-sm mx-auto p-8 mt-16">
      <h1 className="text-2xl font-bold text-primary-dark mb-6 text-center">
        Haven 美髮管理登入
      </h1>

      {error && (
        <div className="mb-4 p-3 rounded-lg bg-red-50 text-red-600 text-sm">
          帳號或密碼錯誤，請再試一次。
        </div>
      )}

      <form
        action={login}
        className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white"
      >
        <input
          name="email"
          type="email"
          autoComplete="email"
          placeholder="帳號 (Email)"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="password"
          type="password"
          autoComplete="current-password"
          placeholder="密碼"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <label className="flex items-center gap-2 text-sm text-foreground/70">
          <input type="checkbox" name="remember" defaultChecked className="accent-primary-dark" />
          記住我的帳號密碼
        </label>
        <button
          type="submit"
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          登入
        </button>
      </form>
    </main>
  );
}
