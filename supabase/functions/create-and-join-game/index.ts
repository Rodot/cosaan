// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
/// <reference types="https://esm.sh/@supabase/functions-js@2.4.4/src/edge-runtime.d.ts" />

import { insertLogs } from "../_repository/logs.repo.ts";
import { insertGame, updateGame } from "../_repository/games.repo.ts";
import {
    addProfileToGame,
    fetchProfile,
} from "../_repository/profiles.repo.ts";
import { corsHeaders } from "../_utils/cors.ts";
import { createSupabaseClient } from "../_utils/supabase.ts";

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

        // create new game
        const [game, profile] = await Promise.all([
            insertGame(supabase),
            fetchProfile(supabase, user?.id),
        ]);

        // add redirect to old rom
        if (profile?.game_id) {
            await updateGame(supabase, profile.game_id, {
                next_game_id: game.id,
            });
        }

        // join game
        await addProfileToGame(supabase, user?.id, game.id);

        // add log
        await insertLogs(supabase, {
            game_id: game.id,
            content: `Game created`,
        });
        // add log
        await insertLogs(supabase, {
            game_id: game.id,
            content: `${profile.name} joined.`,
        });

        const data = {};

        return new Response(JSON.stringify(data), {
            headers: { ...corsHeaders, "Content-Type": "application/json" },
            status: 200,
        });
    } catch (error) {
        console.error(error);
        return new Response(JSON.stringify({ error }), {
            headers: { ...corsHeaders, "Content-Type": "application/json" },
            status: 400,
        });
    }
});
