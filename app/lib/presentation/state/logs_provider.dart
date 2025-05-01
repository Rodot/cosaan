import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/log_model.dart';
import 'package:app/infrastructure/logs_repository.dart' as logs_repository;

part 'logs_provider.g.dart';

@riverpod
Stream<List<Log>> logs(Ref ref, String gameId) {
  return logs_repository.streamLogs(gameId);
}
