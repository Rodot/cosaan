import 'package:app/presentation/layout.dart';
import 'package:app/presentation/screens/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class App extends ConsumerWidget {
  App({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return Layout(HomeScreen());
        },
      ),
      GoRoute(
        path: '/room/:roomId',
        redirect: (context, state) {
          final roomId = state.pathParameters['roomId'];
          if (roomId == null || roomId.isEmpty) {
            return '/';
          }
          return null;
        },
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          debugPrint("params  ${state.pathParameters}");
          return Layout(RoomScreen(roomId));
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(routerConfig: _router);
  }
}
