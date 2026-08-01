"use server";

import { supabase } from "@/lib/supabase";
import { revalidatePath } from "next/cache";
import { cookies } from "next/headers";
import { verifyCustomerToken, CUSTOMER_COOKIE } from "@/lib/customer-identity";

export async function cancelMyAppointment(appointmentId: string) {
  const cookieStore = await cookies();
  const identity = verifyCustomerToken(cookieStore.get(CUSTOMER_COOKIE)?.value);
  if (!identity) return;

  await supabase.rpc("cancel_own_appointment", {
    p_appointment_id: appointmentId,
    p_customer_id: identity.customerId,
  });

  revalidatePath("/my");
}
