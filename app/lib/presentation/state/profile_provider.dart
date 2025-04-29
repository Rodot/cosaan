import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/infrastructure/profile_repository.dart';

part 'profile_provider.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository();
}

@Riverpod(keepAlive: true)
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<Profile> build() async {
    return _signInAnonymously();
  }

  Future<Profile> _signInAnonymously() async {
    state = const AsyncLoading();
    try {
      final profileRepository = ref.read(profileRepositoryProvider);
      return await profileRepository.signInAnonymously();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      throw Exception('Failed to sign in anonymously: ${e.toString()}');
    }
  }

  Future<void> joinRoom() async {
    state = const AsyncLoading();
    try {
      if (state.value == null) {
        throw Exception('Cant join room as profile is null');
      }
      final profileRepository = ref.read(profileRepositoryProvider);
      await profileRepository.joinRoom();
      final updatedProfile = await profileRepository.fetch(state.value!.id);
      state = AsyncData(updatedProfile);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> updateProfile(Profile profile) async {
    state = const AsyncLoading();

    try {
      final profileRepository = ref.read(profileRepositoryProvider);
      final updatedProfile = await profileRepository.update(
        profile.id,
        profile,
      );

      state = AsyncData(updatedProfile);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
