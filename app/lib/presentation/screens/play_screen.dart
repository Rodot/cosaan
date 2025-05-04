import 'package:app/presentation/components/game_share_button.dart';
import 'package:app/presentation/components/game_share_qr.dart';
import 'package:app/presentation/state/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/presentation/components/game_logs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen(this.gameId, {super.key});
  final String gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider(gameId));
    final gameStatus = game.when(
      data: (game) => game.status,
      error: (_, _) => "error",
      loading: () => "loading",
    );
    return Column(
      children: [
        Text("Game #$gameId $gameStatus"),
        GameShareQr(gameId),
        GameShareButton(gameId),
        Expanded(child: GameLogs(gameId)),
      ],
    );
  }
}
