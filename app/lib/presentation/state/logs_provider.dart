import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/log_model.dart';
import 'package:app/infrastructure/logs_repository.dart';

part 'logs_provider.g.dart';

@Riverpod(keepAlive: true)
LogsRepository logsRepository(Ref ref) {
  return LogsRepository();
}

@riverpod
Future<List<Log>> lastestLogs(Ref ref, String roomId) async {
  final logsRepository = ref.read(logsRepositoryProvider);
  return await logsRepository.getLastLogs(roomId);
}
