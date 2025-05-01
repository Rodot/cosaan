import 'package:app/presentation/components/app_error_handler.dart';
import 'package:app/presentation/components/app_loading_bar.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout(this.child, {super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [child, const AppErrorHandler(), const AppLoadingBar()],
      ),
    );
  }
}
