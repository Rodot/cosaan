import 'package:app/presentation/components/profile_name_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_notifier.dart';
import 'package:go_router/go_router.dart';

class GameCreateButton extends ConsumerWidget {
  const GameCreateButton({super.key});

  void createAndJoinGame(BuildContext context, WidgetRef ref) async {
    await ref.read(profileNotifierProvider.notifier).createAndJoinGame();
    final gameId = ref.read(profileNotifierProvider).value?.gameId;
    if (context.mounted && gameId != null) {
      context.go(Uri(path: '/play/$gameId').toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileNotifierProvider);
    final isNamePresent = (profile.value?.name?.length ?? 0) > 0;
    if (!isNamePresent) {
      return ProfileNameField();
    }
    return ElevatedButton(
      onPressed: () => createAndJoinGame(context, ref),
      child: Text("Start New Game"),
    );
  }
}
