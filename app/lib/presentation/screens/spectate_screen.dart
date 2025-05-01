import 'package:app/presentation/state/logs_any_room_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/presentation/components/room_logs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpectateScreen extends ConsumerWidget {
  const SpectateScreen(this.roomId, {super.key});
  final String? roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(logsAnyRoomProvider(roomId ?? ""));
    if (!logsAsync.hasValue && !logsAsync.isLoading) {
      return const Center(child: Text("No room ID provided"));
    }

    return Expanded(child: RoomLogs(roomId!));
  }
}
