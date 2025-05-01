import 'package:app/presentation/layout.dart';
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
        path: '/spectate/:roomId',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return Layout(SpectateScreen(roomId));
        },
      ),
      GoRoute(
        path: '/play',
        builder: (context, state) {
          return Layout(PlayScreen());
        },
      ),
    ],
  );
}
