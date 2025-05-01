#!/bin/bash
set -e

supabase stop --no-backup
./run_start.sh
