import 'package:app/presentation/utils/show_error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_notifier.dart';

class AppErrorHandler extends ConsumerWidget {
  const AppErrorHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(profileNotifierProvider, (previous, next) {
      if (next.hasError) {
        showErrorSnackbar(context, "Profile: ${next.error}");
      }
    });

    return const SizedBox.shrink();
  }
}
