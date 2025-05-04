import 'package:app/presentation/state/session_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/profile_model.dart';
import 'package:app/infrastructure/profile_repository.dart'
    as profile_repository;

part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<Profile> build() async {
    final session = await ref.read(sessionProvider.future);
    final userId = session.user.id;
    final profile = await profile_repository.fetch(userId);
    return profile;
  }

  Future<void> fetch(String userId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final session = await ref.read(sessionProvider.future);
      final userId = session.user.id;
      return profile_repository.fetch(userId);
    });
  }

  Future<void> createAndJoinGame() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await profile_repository.createAndJoinGame();
    });
  }

  Future<void> joinGame(String gameId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await profile_repository.joinGame(gameId);
    });
  }

  Future<void> updateProfile(Profile profile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await profile_repository.update(profile.id, profile);
    });
  }
}
