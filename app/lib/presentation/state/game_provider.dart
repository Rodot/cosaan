import 'package:app/domain/game_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/infrastructure/game_repository.dart' as game_repository;

part 'game_provider.g.dart';

@riverpod
Stream<Game> game(Ref ref, String gameId) {
  return game_repository.streamGame(gameId);
}
