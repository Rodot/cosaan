import 'package:app/presentation/state/current_game_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GameShareQr extends ConsumerWidget {
  const GameShareQr({super.key, this.size = 200.0});

  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(currentGameProvider);
    final gameId = gameAsync.value?.id;
    final shareUrl =
        Uri(
          scheme: Uri.base.scheme,
          host: Uri.base.host,
          port: Uri.base.port != 0 ? Uri.base.port : null,
          path: '/#/join/$gameId',
        ).toString();

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gameAsync.isLoading
              ? SizedBox(height: size, width: size)
              : QrImageView(
                data: shareUrl,
                version: QrVersions.auto,
                size: size,
              ),
          Text(
            'Scan to join game',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
