import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/domain/log_model.dart';

class LogsRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Log>> getLastLogs(String roomId, {int limit = 10}) async {
    final data = await _client
        .from('logs')
        .select('id, content, created_at, room_id')
        .eq('room_id', roomId)
        .order('created_at', ascending: false)
        .limit(limit);

    return data.map((json) => Log.fromJson(json)).toList();
  }
}
