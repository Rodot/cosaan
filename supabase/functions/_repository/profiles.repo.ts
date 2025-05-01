import { SupabaseClient } from "https://esm.sh/v135/@supabase/supabase-js@2.43.2/dist/module/index.js";
import { Tables } from "../_types/database.types.ts";

export const addProfileToGame = async (
  supabase: SupabaseClient,
  userId: string,
  game_id: string,
) => {
  const req = await supabase
    .from("profiles")
    .update([{ game_id: game_id }])
    .eq("id", userId);
  if (req.error) {
    throw new Error(req.error.message);
  }
};

export const fetchProfilesOfGame = async (
  supabase: SupabaseClient,
  game_id: string,
): Promise<Tables<"profiles">[]> => {
  const req = await supabase.from("profiles").select("*").eq(
    "game_id",
    game_id,
  );
  if (req.error) {
    throw new Error(req.error.message);
  } else {
    const gameUsers = req?.data;
    return gameUsers ?? [];
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
