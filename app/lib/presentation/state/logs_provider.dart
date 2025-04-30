import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/log_model.dart';
import 'package:app/infrastructure/logs_repository.dart';
import 'package:app/presentation/state/profile_provider.dart';

part 'logs_provider.g.dart';

@Riverpod(keepAlive: true)
LogsRepository logsRepository(Ref ref) {
  return LogsRepository();
}

@Riverpod(keepAlive: true)
class LogsNotifier extends _$LogsNotifier {
  @override
  Future<List<Log>> build() async {
    final profile = await ref.watch(profileNotifierProvider.future);
    if (profile.roomId == null) {
      return [];
    }
    return _fetchLogs(profile.roomId!);
  }

  Future<List<Log>> _fetchLogs(String roomId) async {
    final logsRepository = ref.read(logsRepositoryProvider);
    return await logsRepository.getLastLogs(roomId);
  }
}
