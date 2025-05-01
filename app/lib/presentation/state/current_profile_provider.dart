import 'package:app/domain/profile_model.dart';
import 'package:app/presentation/state/current_session_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/infrastructure/profile_repository.dart'
    as profile_repository;

part 'current_profile_provider.g.dart';

@riverpod
Stream<Profile> currentProfile(Ref ref) {
  final session = ref.watch(currentSessionProvider);
  final userId = session.value?.user.id;
  if (userId != null) {
    return profile_repository.streamProfile(userId);
  }
  return Stream.value(dummyProfile);
}
