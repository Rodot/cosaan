import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_provider.dart';

class RoomManagementButtons extends ConsumerWidget {
  const RoomManagementButtons({super.key});

  void createAndJoinRoom(WidgetRef ref) {
    ref.read(profileNotifierProvider.notifier).createAndJoinRoom();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileNotifierProvider);
    final isNameSaved = (profile.value?.name?.length ?? 0) > 0;
    final isButtonEnabled = isNameSaved && !profile.isLoading;
    return ElevatedButton(
      onPressed: isButtonEnabled ? () => createAndJoinRoom(ref) : null,
      child: Text("Start New Game"),
    );
  }
}
