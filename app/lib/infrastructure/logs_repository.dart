import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/domain/log_model.dart';

class LogsRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Stream<List<Log>> streamLogs(String roomId, {int limit = 10}) {
    return _client
        .from('logs')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .order('created_at', ascending: false)
        .limit(limit)
        .map((data) => data.map((json) => Log.fromJson(json)).toList());
  }
}
