import 'package:app/presentation/state/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/presentation/components/profile_name_field.dart';
import 'package:app/presentation/components/game_logs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameId = ref.watch(profileNotifierProvider).value?.gameId;
    if (gameId == null) {
      return Center(
        child: Text("You are not in a game. Please create or join one."),
      );
    }
    return Column(
      children: [
        ProfileNameField(),
        SizedBox(height: 16.0),
        Expanded(child: GameLogs(gameId)),
      ],
    );
  }
}
