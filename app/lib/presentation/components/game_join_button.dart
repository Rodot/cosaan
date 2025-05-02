import 'package:app/presentation/state/current_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_notifier.dart';
import 'package:go_router/go_router.dart';

class GameJoinButton extends ConsumerWidget {
  const GameJoinButton({super.key, required this.gameId});
  final String gameId;

  void joinGame(BuildContext context, WidgetRef ref) async {
    await ref.read(profileNotifierProvider.notifier).joinGame(gameId);
    if (context.mounted) {
      context.go(Uri(path: '/play').toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(currentProfileProvider);
    final isNameSaved = (profile.value?.name?.length ?? 0) > 0;
    final isButtonEnabled = isNameSaved && !profile.isLoading;
    return ElevatedButton(
      onPressed: isButtonEnabled ? () => joinGame(context, ref) : null,
      child: Text("Join Game"),
    );
  }
}
