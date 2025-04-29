import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/domain/models/user.dart';

class UserProfileRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<UserProfile> fetch(String userId) async {
    final json =
        await _client
            .from('user_profiles')
            .select('id, name, room_id, created_at')
            .eq('id', userId)
            .single();
    return UserProfile.fromJson(json);
  }

  Future<UserProfile> update(String userId, UserProfile updatedProfile) async {
    final updates = {
      'name': updatedProfile.name,
      'room_id': updatedProfile.roomId,
    };
    final json =
        await _client
            .from('user_profiles')
            .update(updates)
            .eq('id', userId)
            .select()
            .single();
    return UserProfile.fromJson(json);
  }

  Future<UserProfile> signInAnonymously() async {
    final Session? session = _client.auth.currentSession;
    return session != null
        ? _fetchExistingUser(session)
        : _createAnonymousUser();
  }

  Future<UserProfile> _fetchExistingUser(Session session) async {
    return await fetch(session.user.id);
  }

  Future<UserProfile> _createAnonymousUser() async {
    final response = await _client.auth.signInAnonymously();
    final user = _validateUserResponse(response);
    return await fetch(user.id);
  }

  User _validateUserResponse(AuthResponse response) {
    final user = response.user;
    if (user == null) {
      throw Exception('Error signing in anonymously: No user found');
    }
    return user;
  }
}
