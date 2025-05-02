import 'package:app/presentation/components/game_share_button.dart';
import 'package:app/presentation/components/game_share_qr.dart';
import 'package:app/presentation/state/current_game_provider.dart';
import 'package:app/presentation/state/current_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/presentation/components/game_logs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentProfileProvider);
    final game = ref.watch(currentGameProvider);
    final gameId = profileAsync.value?.gameId ?? "";
    final gameStatus = game.when(
      data: (game) => game?.status ?? "unknown",
      error: (_, _) => "error",
      loading: () => "loading",
    );
    return Column(
      children: [
        Text("Game #$gameId $gameStatus"),
        GameShareQr(),
        GameShareButton(),
        Expanded(child: GameLogs()),
      ],
    );
  }
}
