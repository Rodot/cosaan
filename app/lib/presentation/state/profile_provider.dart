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

  Future<T> _executeWithLoading<T>(Future<T> Function() operation) async {
    state = const AsyncValue.loading();
    try {
      final result = await operation();
      state = AsyncValue.data(result as Profile);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<Profile> _signInAnonymously() async {
    final profileRepository = ref.read(profileRepositoryProvider);
    return await profileRepository.signInAnonymously();
  }

  Future<void> createAndJoinRoom() async {
    await _executeWithLoading(() async {
      if ((state.value?.name?.length ?? 0) < 3) {
        throw Exception(
          "Can't join a room with a name shorter than 3 characters",
        );
      }
      final profileRepository = ref.read(profileRepositoryProvider);
      await profileRepository.createAndJoinRoom();
      return await profileRepository.fetch(state.value!.id);
    });
  }

  Future<void> updateProfile(Profile profile) async {
    await _executeWithLoading(() async {
      final profileRepository = ref.read(profileRepositoryProvider);
      return await profileRepository.update(profile.id, profile);
    });
  }
}
