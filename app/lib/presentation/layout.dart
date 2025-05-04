import 'package:app/presentation/components/app_error_handler.dart';
import 'package:app/presentation/components/app_loading_bar.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout(this.gameId, this.child, {super.key});
  final Widget child;
  final String? gameId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: child,
            ),
          ),
          AppErrorHandler(gameId),
          AppLoadingBar(gameId),
        ],
      ),
    );
  }
}
