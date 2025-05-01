import 'package:app/domain/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:app/infrastructure/profile_repository.dart'
    as profile_repository;

part 'profile_provider.g.dart';

@riverpod
Stream<Profile> profile(Ref ref, String profileId) {
  return profile_repository.streamProfile(profileId);
}
