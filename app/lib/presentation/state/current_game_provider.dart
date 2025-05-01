import 'package:app/domain/game_model.dart';
import 'package:app/presentation/state/current_profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/infrastructure/game_repository.dart' as game_repository;

part 'current_game_provider.g.dart';

@riverpod
Stream<Game> currentGame(Ref ref) {
  final profileAsync = ref.watch(currentProfileProvider);
  final gameId = profileAsync.value?.gameId;
  if (gameId != null) {
    return game_repository.streamGame(gameId);
  }
  return Stream.value(dummyGame);
}
