import 'package:app/presentation/layout.dart';
import 'package:app/presentation/screens/create_screen.dart';
import 'package:app/presentation/screens/home_screen.dart';
import 'package:app/presentation/screens/join_screen.dart';
import 'package:app/presentation/screens/play_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter routerConfig() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return Layout(HomeScreen());
        },
      ),
      GoRoute(
        path: '/play',
        builder: (context, state) {
          return Layout(PlayScreen());
        },
      ),
      GoRoute(
        path: '/create',
        builder: (context, state) {
          return Layout(CreateScreen());
        },
      ),
      GoRoute(
        path: '/join/:gameId',
        redirect: (context, state) {
          final gameId = state.pathParameters['gameId'];
          if (gameId == null) {
            return '/';
          }
          return null;
        },
        builder: (context, state) {
          final gameId = state.pathParameters['gameId'];
          debugPrint("Game ID: $gameId");
          return Layout(JoinScreen(gameId: gameId!));
        },
      ),
    ],
  );
}
