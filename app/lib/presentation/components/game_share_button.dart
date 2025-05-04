import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameShareButton extends ConsumerWidget {
  const GameShareButton(this.gameId, {super.key});
  final String gameId;

  void copyToClipboard(BuildContext context, String text) {
    final data = ClipboardData(text: text);
    Clipboard.setData(data);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Copied to clipboard")));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shareUrl =
        Uri(
          scheme: Uri.base.scheme,
          host: Uri.base.host,
          port: Uri.base.port != 0 ? Uri.base.port : null,
          path: '/',
          fragment: '/join/$gameId',
        ).toString();
    return ElevatedButton.icon(
      onPressed: () => copyToClipboard(context, shareUrl),
      icon: const Icon(Icons.content_copy),
      label: Text("Copy game link"),
    );
  }
}
