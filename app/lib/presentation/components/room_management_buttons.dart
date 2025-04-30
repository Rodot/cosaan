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
    return ElevatedButton(
      onPressed: () => createAndJoinRoom(ref),
      child: Text("Start New Game"),
    );
  }
}
