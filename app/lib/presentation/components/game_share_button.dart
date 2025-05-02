import 'package:app/presentation/state/current_game_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameShareButton extends ConsumerWidget {
  const GameShareButton({super.key});

  void copyToClipboard(BuildContext context, String text) {
    final data = ClipboardData(text: text);
    Clipboard.setData(data);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Copied to clipboard")));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(currentGameProvider);
    final gameId = gameAsync.value?.id;
    final shareUrl =
        Uri(
          scheme: Uri.base.scheme,
          host: Uri.base.host,
          port: Uri.base.port != 0 ? Uri.base.port : null,
          path: '/',
          fragment: '/join/$gameId',
        ).toString();
    final isButtonEnabled = !gameAsync.isLoading && gameId != null;
    return ElevatedButton.icon(
      onPressed:
          isButtonEnabled ? () => copyToClipboard(context, shareUrl) : null,
      icon: const Icon(Icons.content_copy),
      label: Text("Copy game link"),
    );
  }
}
