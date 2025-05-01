import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/domain/log_model.dart';

Stream<List<Log>> streamLogs(String gameId, {int limit = 10}) {
  final SupabaseClient client = Supabase.instance.client;

  return client
      .from('logs')
      .stream(primaryKey: ['id'])
      .eq('game_id', gameId)
      .order('created_at', ascending: false)
      .limit(limit)
      .map((data) => data.map((json) => Log.fromJson(json)).toList());
}
