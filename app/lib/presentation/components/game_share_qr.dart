import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GameShareQr extends ConsumerWidget {
  const GameShareQr(this.gameId, {super.key, this.size = 200.0});
  final String gameId;

  final double size;

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

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(data: shareUrl, version: QrVersions.auto, size: size),
          Text(
            'Scan to join game',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
