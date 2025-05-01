import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/domain/profile_model.dart';
import 'package:app/infrastructure/profile_repository.dart'
    as profile_repository;

part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<void> build() async {}

  Future<void> createAndJoinGame() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await profile_repository.createAndJoinGame();
    });
  }

  Future<void> updateProfile(Profile profile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await profile_repository.update(profile.id, profile);
    });
  }
}
