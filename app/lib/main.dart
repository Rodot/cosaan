import 'package:app/infrastructure/supabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/app.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

bool _isUrlStrategySet = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!_isUrlStrategySet) {
    setUrlStrategy(HashUrlStrategy());
    _isUrlStrategySet = true;
  }

  await initializeSupabase();
  runApp(ProviderScope(child: App()));
}
