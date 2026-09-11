"use server";

import { createClient } from "@/lib/supabase-server";
import { redirect } from "next/navigation";

// 帳號用簡單的使用者名稱登入，內部再對應回 Supabase Auth 實際使用的 email
const USERNAME_TO_EMAIL: Record<string, string> = {
  kiki: "kiki660438@gmail.com",
};

export async function login(formData: FormData) {
  const username = ((formData.get("username") as string) || "").trim().toLowerCase();
  const password = formData.get("password") as string;
  const email = USERNAME_TO_EMAIL[username] ?? username;

  const supabase = await createClient();
  const { error } = await supabase.auth.signInWithPassword({ email, password });

  if (error) {
    redirect("/login?error=1");
  }

  redirect("/");
}

export async function logout() {
  const supabase = await createClient();
  await supabase.auth.signOut();
  redirect("/login");
}
