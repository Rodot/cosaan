import { SupabaseClient } from "https://esm.sh/v135/@supabase/supabase-js@2.43.2/dist/module/index.js";
import { Tables, TablesInsert } from "../_types/database.types.ts";

export const fetchLogs = async (
  supabase: SupabaseClient,
  game_id: string,
) => {
  const { data, error } = await supabase
    .from("logs")
    .select("*")
    .eq("game_id", game_id);

  if (error) {
    console.error("Error fetching logs:", error);
    return [];
  } else {
    return data as Tables<"logs">[];
  }
};

export const insertLogs = async (
  supabase: SupabaseClient,
  log: TablesInsert<"logs">,
) => {
  const insertLogResponse = await supabase
    .from("logs")
    .insert([log]);
  if (insertLogResponse.error) {
    throw new Error(
      "Error inserting log: " + insertLogResponse.error.message,
    );
  }
};
