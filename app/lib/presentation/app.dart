import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/screens/profile_screen.dart';
import 'package:app/presentation/components/app_loading_bar.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: const [ProfileScreen(), AppLoadingBar()]),
      ),
    );
  }
}
