import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/infrastructure/user_profile_repository.dart';

part 'user_profile_provider.g.dart';

@Riverpod(keepAlive: true)
UserProfileRepository userProfileRepository(Ref ref) {
  return UserProfileRepository();
}

@Riverpod(keepAlive: true)
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<UserProfile?> build() async {
    return _signInAnonymously();
  }

  Future<UserProfile?> _signInAnonymously() async {
    try {
      final userProfileRepository = ref.read(userProfileRepositoryProvider);
      return await userProfileRepository.signInAnonymously();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      return null;
    }
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    state = const AsyncLoading();

    try {
      final userProfileRepository = ref.read(userProfileRepositoryProvider);
      final updatedProfile = await userProfileRepository.update(
        userProfile.id,
        userProfile,
      );

      state = AsyncData(updatedProfile);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
