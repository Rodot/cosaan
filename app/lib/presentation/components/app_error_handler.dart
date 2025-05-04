import 'package:app/presentation/state/game_provider.dart';
import 'package:app/presentation/state/logs_provider.dart';
import 'package:app/presentation/utils/show_error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_notifier.dart';

class AppErrorHandler extends ConsumerWidget {
  const AppErrorHandler(this.gameId, {super.key});
  final String? gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(profileNotifierProvider, (previous, next) {
      if (next.hasError) {
        showErrorSnackbar(context, "Action: ${next.error}");
      }
    });

    if (gameId != null) {
      ref.listen(gameProvider(gameId!), (previous, next) {
        if (next.hasError) {
          showErrorSnackbar(context, "Game: ${next.error}");
        }
      });

      ref.listen(logsProvider(gameId!), (previous, next) {
        if (next.hasError) {
          showErrorSnackbar(context, "Logs: ${next.error}");
        }
      });
    }

    return const SizedBox.shrink();
  }
}
