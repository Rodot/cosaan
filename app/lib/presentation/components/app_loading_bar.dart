import 'package:app/presentation/state/game_provider.dart';
import 'package:app/presentation/state/logs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_notifier.dart';

class AppLoadingBar extends ConsumerWidget {
  const AppLoadingBar(this.gameId, {super.key});
  final String? gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoadingProfile = ref.watch(profileNotifierProvider).isLoading;
    final isLoadingGame =
        gameId == null ? false : ref.watch(gameProvider(gameId!)).isLoading;
    final isLoadingLogs =
        gameId == null ? false : ref.watch(logsProvider(gameId!)).isLoading;
    final isLoading = isLoadingProfile || isLoadingGame || isLoadingLogs;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 3,
      child: isLoading ? const LinearProgressIndicator() : const SizedBox(),
    );
  }
}
