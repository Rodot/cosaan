import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_provider.dart';
import 'package:go_router/go_router.dart';

class RoomManagementButtons extends ConsumerWidget {
  const RoomManagementButtons({super.key});

  void createAndJoinRoom(BuildContext context, WidgetRef ref) async {
    var profile =
        await ref.read(profileNotifierProvider.notifier).createAndJoinRoom();
    if (context.mounted && profile?.roomId != null) {
      context.go(Uri(path: '/play').toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileNotifierProvider);
    final isNameSaved = (profile.value?.name?.length ?? 0) > 0;
    final isButtonEnabled = isNameSaved && !profile.isLoading;
    return ElevatedButton(
      onPressed: isButtonEnabled ? () => createAndJoinRoom(context, ref) : null,
      child: Text("Start New Game"),
    );
  }
}
