#!/bin/bash
set -e

supabase stop --no-backup
supabase start --exclude vector
supabase test db
supabase db lint
npx -y supabase gen types typescript --local >./functions/_types/database.types.ts
