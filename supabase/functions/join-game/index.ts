// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
/// <reference types="https://esm.sh/@supabase/functions-js@2.4.4/src/edge-runtime.d.ts" />

import { insertLogs } from "../_repository/logs.repo.ts";
import { corsHeaders } from "../_utils/cors.ts";
import { createSupabaseClient } from "../_utils/supabase.ts";
import { TablesInsert } from "../_types/database.types.ts";
import {
    addProfileToGame,
    fetchProfile,
} from "../_repository/profiles.repo.ts";
import { fetchGame } from "../_repository/games.repo.ts";

Deno.serve(async (req) => {
    if (req.method === "OPTIONS") {
        return new Response("ok", { headers: corsHeaders });
    }

    try {
        const supabase = createSupabaseClient(req);
        const userResponse = await supabase.auth.getUser();
        if (userResponse.error) {
            throw new Error(userResponse.error.message);
        }
        const user = userResponse.data.user;

        const params = (await req.json()) as TablesInsert<"games">;

        if (!params?.id) throw new Error("Room ID is required");

        // join game
        const [game, profile] = await Promise.all([
            fetchGame(supabase, params.id),
            fetchProfile(supabase, user?.id),
        ]);

        if (game?.status !== "lobby") {
            const data = JSON.stringify({ error: "Game already started" });
            return new Response(data, { headers: corsHeaders, status: 400 });
        }

        await Promise.all([
            addProfileToGame(supabase, user?.id, params.id),
            insertLogs(supabase, {
                game_id: params.id,
                content: `${profile.name} joined.`,
            }),
        ]);

        const data = JSON.stringify({ ...profile, game_id: params.id });
        return new Response(data, { headers: corsHeaders, status: 200 });
    } catch (error) {
        const data = JSON.stringify(error);
        return new Response(data, { headers: corsHeaders, status: 400 });
    }
});
