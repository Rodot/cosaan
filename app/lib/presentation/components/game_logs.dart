import 'package:app/presentation/state/current_logs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/domain/log_model.dart';

class GameLogs extends ConsumerWidget {
  const GameLogs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(currentLogsProvider).value ?? [];
    return _buildLogsList(logs);
  }

  Widget _buildLogsList(List<Log> logs) {
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        return _buildLogItem(log);
      },
    );
  }

  Widget _buildLogItem(Log log) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(log.content),
      ),
    );
  }
}
