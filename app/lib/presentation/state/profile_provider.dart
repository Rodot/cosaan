import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/profile_model.dart';
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
    final profileRepository = ref.read(profileRepositoryProvider);
    return await profileRepository.signInAnonymously();
  }

  Future<void> joinRoom() async {
    state = AsyncLoading();
    if (state.value == null) {
      throw Exception('Cant join room as profile is null');
    }
    final profileRepository = ref.read(profileRepositoryProvider);
    await profileRepository.joinRoom();
    final updatedProfile = await profileRepository.fetch(state.value!.id);
    state = AsyncData(updatedProfile);
  }

  Future<void> updateProfile(Profile profile) async {
    state = AsyncLoading();
    final profileRepository = ref.read(profileRepositoryProvider);
    final updatedProfile = await profileRepository.update(profile.id, profile);
    state = AsyncData(updatedProfile);
  }
}
