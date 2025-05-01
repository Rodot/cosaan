#!/bin/bash
set -e

supabase start --exclude vector
npx supabase functions serve --env-file ./.env
