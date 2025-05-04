#!/bin/bash
set -e

echo "⚡ Starting Supabase..."
supabase start -x storage-api -x imgproxy -x mailpit -x logflare -x vector -x edge-runtime
echo "⚡ Resetting Supabase..."
supabase db reset
echo "⚡ Testing db..."
supabase test db
supabase db lint
echo "⚡ Generating types..."
npx -y supabase gen types typescript --local >./functions/_types/database.types.ts
echo "⚡ Serving functions..."
npx supabase functions serve --env-file ./.env
