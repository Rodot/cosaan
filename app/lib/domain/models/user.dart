import 'package:equatable/equatable.dart';

/// Domain entity representing a user in the system
class UserProfile extends Equatable {
  final String id;
  final String? name;
  final String? roomId;
  final DateTime? createdAt;

  const UserProfile({required this.id, this.name, this.roomId, this.createdAt});

  /// Creates a new UserProfile with updated properties
  UserProfile copyWith({String? name, String? roomId}) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      roomId: roomId ?? this.roomId,
      createdAt: createdAt,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String?,
      roomId: json['room_id'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'] as String)
              : null,
    );
  }

  @override
  List<Object?> get props => [id, name, roomId, createdAt];
}
