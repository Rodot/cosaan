import 'package:app/presentation/state/current_profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/log_model.dart';
import 'package:app/infrastructure/logs_repository.dart' as logs_repository;

part 'current_logs_provider.g.dart';

@riverpod
Stream<List<Log>> currentLogs(Ref ref) {
  final profileAsync = ref.watch(currentProfileProvider);
  final gameId = profileAsync.value?.gameId;
  if (gameId == null) {
    return Stream.value([]);
  }
  return logs_repository.streamLogs(gameId);
}
