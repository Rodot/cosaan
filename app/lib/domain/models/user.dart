import 'package:equatable/equatable.dart';

/// Domain entity representing a user in the system
class Profile extends Equatable {
  final String id;
  final String? name;
  final String? roomId;
  final DateTime createdAt;

  const Profile({
    required this.id,
    this.name,
    this.roomId,
    required this.createdAt,
  });

  /// Creates a new Profile with updated properties
  Profile copyWith({String? name, String? roomId}) {
    return Profile(
      id: id,
      name: name ?? this.name,
      roomId: roomId ?? this.roomId,
      createdAt: createdAt,
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id')) {
      throw Exception('Profile missing required id field');
    }

    return Profile(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name']?.toString(),
      roomId: json['room_id']?.toString(),
    );
  }

  @override
  List<Object?> get props => [id, name, roomId, createdAt];
}
