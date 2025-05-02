import 'package:app/presentation/state/current_game_provider.dart';
import 'package:app/presentation/state/current_logs_provider.dart';
import 'package:app/presentation/state/current_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_notifier.dart';

class AppLoadingBar extends ConsumerWidget {
  const AppLoadingBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileNotifierAsync = ref.watch(profileNotifierProvider);
    final currentProfileAsync = ref.watch(currentProfileProvider);
    final currentGameAsync = ref.watch(currentGameProvider);
    final currentLogsAsync = ref.watch(currentLogsProvider);
    final isLoading =
        profileNotifierAsync.isLoading ||
        currentProfileAsync.isLoading ||
        currentLogsAsync.isLoading ||
        currentGameAsync.isLoading;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 3,
      child: isLoading ? const LinearProgressIndicator() : const SizedBox(),
    );
  }
}
