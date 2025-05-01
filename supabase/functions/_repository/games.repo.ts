import { SupabaseClient } from "https://esm.sh/v135/@supabase/supabase-js@2.43.2/dist/module/index.js";
import { Tables, TablesInsert } from "../_types/database.types.ts";

export const fetchGame = async (supabase: SupabaseClient, id: string) => {
  const req = await supabase.from("games").select("*").eq("id", id);
  if (req.error) {
    throw new Error(req.error.message);
  }
  const game: Tables<"games"> | null = req?.data?.[0] ?? null;
  return game;
};

export const insertGame = async (supabase: SupabaseClient) => {
  const req = await supabase.from("games").insert({}).select();
  if (req.error) {
    throw new Error(req.error.message);
  }
  const game: Tables<"games"> = req?.data?.[0];
  return game;
};

export const updateGame = async (
  supabase: SupabaseClient,
  id: string,
  data: TablesInsert<"games">,
) => {
  const req = await supabase.from("games").update(data).eq("id", id);
  if (req.error) {
    throw new Error(req.error.message);
  }
};
