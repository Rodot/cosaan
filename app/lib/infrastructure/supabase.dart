import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initializeSupabase() async {
  await dotenv.load();
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
  if (supabaseUrl == null || supabaseAnonKey == null) {
    throw Exception('Supabase URL or Anon Key not found in .env file');
  }
  try {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  } catch (e) {
    log('Supabase initialization failed: $e', name: 'main');
  }
}
