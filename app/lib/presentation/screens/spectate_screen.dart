import 'package:app/presentation/state/logs_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/presentation/components/game_logs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpectateScreen extends ConsumerWidget {
  const SpectateScreen(this.gameId, {super.key});
  final String? gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(logsProvider(gameId ?? ""));
    if (!logsAsync.hasValue && !logsAsync.isLoading) {
      return const Center(child: Text("No game ID provided"));
    }

    return Expanded(child: GameLogs(gameId!));
  }
}
