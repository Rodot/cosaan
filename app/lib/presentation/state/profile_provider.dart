import 'package:app/infrastructure/session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/profile_model.dart';
import 'package:app/infrastructure/profile_repository.dart'
    as profile_repository;

part 'profile_provider.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<Profile> build() async {
    final session = await getUserSession();
    return profile_repository.fetch(session.user.id);
  }

  Future<Profile?> createAndJoinGame() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await profile_repository.createAndJoinGame();
      return await profile_repository.fetch(state.value!.id);
    });
    return state.value;
  }

  Future<Profile?> joinGame() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await profile_repository.joinGame();
      return await profile_repository.fetch(state.value!.id);
    });
    return state.value;
  }

  Future<Profile?> updateProfile(Profile profile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await profile_repository.update(profile.id, profile);
    });
    return state.value;
  }
}
