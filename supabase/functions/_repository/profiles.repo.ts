import { SupabaseClient } from "https://esm.sh/v135/@supabase/supabase-js@2.43.2/dist/module/index.js";
import { Tables } from "../_types/database.types.ts";

export const addProfileToRoom = async (
  supabase: SupabaseClient,
  userId: string,
  room_id: string,
) => {
  const req = await supabase
    .from("profiles")
    .update([{ room_id: room_id }])
    .eq("id", userId);
  if (req.error) {
    throw new Error(req.error.message);
  }
};

export const fetchProfilesOfRoom = async (
  supabase: SupabaseClient,
  room_id: string,
): Promise<Tables<"profiles">[]> => {
  const req = await supabase.from("profiles").select("*").eq(
    "room_id",
    room_id,
  );
  if (req.error) {
    throw new Error(req.error.message);
  } else {
    const roomUsers = req?.data;
    return roomUsers ?? [];
  }
};

export const fetchProfile = async (
  supabase: SupabaseClient,
  userId: string,
): Promise<Tables<"profiles">> => {
  const req = await supabase.from("profiles").select("*").eq("id", userId);
  if (req.error) {
    throw new Error(req.error.message);
  } else {
    const profile = req?.data?.[0];
    return profile;
  }
};
