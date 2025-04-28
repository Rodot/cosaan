import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/domain/models/user.dart';

/// Repository responsible for user-related data operations
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

  /// Updates user profile in the database
  Future<UserProfile?> update(String userId, UserProfile updatedProfile) async {
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

    // User is already signed in, fetch their profile
    if (session != null) {
      final userProfile = await fetch(session.user.id);
      return userProfile;
    }

    // Sign in anonymously
    final response = await _client.auth.signInAnonymously();
    if (response.user == null) {
      throw Exception('Error signing in anonymously: No user found');
    }
    final userProfile = await fetch(response.user!.id);
    return userProfile;
  }
}
