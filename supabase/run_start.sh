#!/bin/bash
set -e

supabase start --exclude vector
supabase db reset
supabase test db
supabase db lint
npx -y supabase gen types typescript --local >./functions/_types/database.types.ts
npx supabase functions serve --env-file ./.env
