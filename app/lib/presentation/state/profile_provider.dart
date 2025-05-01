import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/profile_model.dart';
import 'package:app/infrastructure/profile_repository.dart';

part 'profile_provider.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository();
}

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<Profile> build() async {
    return _signInAnonymously();
  }

  Future<Profile> _signInAnonymously() async {
    final profileRepository = ref.read(profileRepositoryProvider);
    return await profileRepository.signInAnonymously();
  }

  Future<Profile?> createAndJoinGame() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final profileRepository = ref.read(profileRepositoryProvider);
      await profileRepository.createAndJoinGame();
      return await profileRepository.fetch(state.value!.id);
    });
    return state.value;
  }

  Future<Profile?> joinGame() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final profileRepository = ref.read(profileRepositoryProvider);
      await profileRepository.joinGame();
      return await profileRepository.fetch(state.value!.id);
    });
    return state.value;
  }

  Future<Profile?> updateProfile(Profile profile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final profileRepository = ref.read(profileRepositoryProvider);
      return await profileRepository.update(profile.id, profile);
    });
    return state.value;
  }
}
