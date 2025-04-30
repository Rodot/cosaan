import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/domain/log_model.dart';
import 'package:app/presentation/state/logs_provider.dart';
import 'package:intl/intl.dart';

String firstFiveUppercase(String text) {
  if (text.isEmpty) return '';
  final length = text.length >= 5 ? 5 : text.length;
  return text.substring(0, length).toUpperCase();
}

class RoomLogs extends ConsumerWidget {
  const RoomLogs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(logsNotifierProvider).value ?? [];
    return _buildLogsList(logs);
  }

  Widget _buildLogsList(List<Log> logs) {
    final roomIdShort =
        logs.isNotEmpty ? firstFiveUppercase(logs.first.roomId) : 'XXXXX';
    final roomName = "ROOM #$roomIdShort";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            roomName,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return _buildLogItem(log);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLogItem(Log log) {
    final dateFormat = DateFormat('HH:mm');
    final formattedDate = dateFormat.format(log.createdAt);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(log.content, style: const TextStyle(fontSize: 16.0)),
            const SizedBox(height: 8.0),
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
