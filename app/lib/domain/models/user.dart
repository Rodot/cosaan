import 'package:equatable/equatable.dart';

/// Domain entity representing a user in the system
class UserProfile extends Equatable {
  final String id;
  final String? name;
  final String? roomId;
  final DateTime createdAt;

  const UserProfile({
    required this.id,
    this.name,
    this.roomId,
    required this.createdAt,
  });

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
    if (!json.containsKey('id')) {
      throw Exception('UserProfile missing required id field');
    }

    return UserProfile(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name']?.toString(),
      roomId: json['room_id']?.toString(),
    );
  }

  @override
  List<Object?> get props => [id, name, roomId, createdAt];
}
