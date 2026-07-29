"use server";

import { supabase } from "@/lib/supabase";
import { revalidatePath } from "next/cache";

export async function updateAppointmentStatus(id: string, status: string) {
  await supabase.from("appointments").update({ status }).eq("id", id);
  revalidatePath("/appointments");
}
