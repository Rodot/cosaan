import 'package:app/presentation/state/logs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_provider.dart';

class AppLoadingBar extends ConsumerWidget {
  const AppLoadingBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileNotifierProvider);
    final logs = ref.watch(logsNotifierProvider);
    final isLoading = profile.isLoading || logs.isLoading;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 3,
      child: isLoading ? const LinearProgressIndicator() : const SizedBox(),
    );
  }
}
