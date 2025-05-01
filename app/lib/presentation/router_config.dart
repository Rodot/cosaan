import 'package:app/presentation/layout.dart';
import 'package:app/presentation/screens/create_screen.dart';
import 'package:app/presentation/screens/home_screen.dart';
import 'package:app/presentation/screens/play_screen.dart';
import 'package:app/presentation/screens/spectate_screen.dart';
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
        path: '/spectate/:gameId',
        builder: (context, state) {
          final gameId = state.pathParameters['gameId']!;
          return Layout(SpectateScreen(gameId));
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
    ],
  );
}
