import 'package:app/presentation/layout.dart';
import 'package:app/presentation/screens/home_screen.dart';
import 'package:app/presentation/screens/room_screen.dart';
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
          return Layout(RoomScreen(roomId));
        },
      ),
    ],
  );
}
