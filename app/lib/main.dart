import 'package:app/infrastructure/supabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSupabase();
  runApp(const ProviderScope(child: App()));
}
