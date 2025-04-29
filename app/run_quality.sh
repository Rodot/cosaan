#!/bin/bash
set -e

echo "🔨 Starting Supabase (excluding vector)..."
cd ..
supabase start --exclude vector
cd app

echo "🔨 Terminating any running chromedriver processes..."
pkill -f chromedriver || true

echo "🔨 Running Dart analysis..."
dart analyze

echo "🔨 Running custom lint..."
dart run custom_lint

echo "🔨 Getting Flutter dependencies..."
flutter pub get

echo "🔨 Building web application for testing..."
flutter build web -t integration_test/app_test.dart --release --dart-define=CI=true

echo "🔨 Starting chromedriver on port 4444..."
npx -y chromedriver --port=4444 &

echo "🔨 Running Flutter integration tests..."
flutter drive \
  --driver=integration_test/integration_test.dart \
  --target=integration_test/app_test.dart \
  -d chrome

echo "🔨 Cleaning up: terminating chromedriver..."
pkill -f chromedriver || true
