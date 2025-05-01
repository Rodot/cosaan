import 'dart:async';
import 'package:app/domain/game_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Stream<Game?> streamGame(String gameId) {
  return Supabase.instance.client
      .from('games')
      .stream(primaryKey: ['id'])
      .eq('id', gameId)
      .limit(1)
      .map((data) => data.isNotEmpty ? Game.fromJson(data[0]) : null);
}
