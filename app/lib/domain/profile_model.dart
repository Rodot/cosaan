import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String id,
    String? name,
    String? gameId,
    required DateTime createdAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

final dummyDate = DateTime(2000, 1, 1);

final dummyProfile = Profile(
  id: 'XXXXX',
  name: 'XXXXX',
  gameId: 'XXXXX',
  createdAt: dummyDate,
);
