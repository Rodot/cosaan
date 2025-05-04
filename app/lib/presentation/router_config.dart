import 'package:app/presentation/layout.dart';
import 'package:app/presentation/screens/home_screen.dart';
import 'package:app/presentation/screens/join_screen.dart';
import 'package:app/presentation/screens/play_screen.dart';
import 'package:app/presentation/utils/show_error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String? goToHomeOnMissingGameId(BuildContext context, GoRouterState state) {
  final gameId = state.pathParameters['gameId'];
  if (gameId == null) {
    showErrorSnackbar(context, "Missing game ID");
    return '/';
  }
  final isValidUUID = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
  ).hasMatch(gameId);
  if (!isValidUUID) {
    showErrorSnackbar(context, "Invalid game ID");
    return '/';
  }
  return null;
}

GoRouter routerConfig() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return Layout(null, HomeScreen());
        },
      ),
      GoRoute(
        path: '/play/:gameId',
        redirect: goToHomeOnMissingGameId,
        builder: (context, state) {
          final gameId = state.pathParameters['gameId'];
          debugPrint("Game ID: $gameId");
          return Layout(gameId, PlayScreen(gameId!));
        },
      ),
      GoRoute(
        path: '/join/:gameId',
        redirect: goToHomeOnMissingGameId,
        builder: (context, state) {
          final gameId = state.pathParameters['gameId'];
          debugPrint("Game ID: $gameId");
          return Layout(gameId, JoinScreen(gameId!));
        },
      ),
    ],
  );
}
