import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/domain/profile_model.dart';

class ProfileRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Profile> fetch(String userId) async {
    final json =
        await _client
            .from('profiles')
            .select('id, name, game_id, created_at')
            .eq('id', userId)
            .single();
    return Profile.fromJson(json);
  }

  Future<Profile> update(String userId, Profile updatedProfile) async {
    final updates = {
      'name': updatedProfile.name,
      'game_id': updatedProfile.gameId,
    };
    final json =
        await _client
            .from('profiles')
            .update(updates)
            .eq('id', userId)
            .select()
            .single();
    return Profile.fromJson(json);
  }

  Future<void> createAndJoinGame() async {
    await _client.functions.invoke('create-and-join-game');
  }

  Future<void> joinGame() async {
    await _client.functions.invoke('create-and-join-game');
  }

  Future<Profile> signInAnonymously() async {
    final Session? session = _client.auth.currentSession;
    return session != null
        ? _fetchExistingUser(session)
        : _createAnonymousUser();
  }

  Future<Profile> _fetchExistingUser(Session session) async {
    return await fetch(session.user.id);
  }

  Future<Profile> _createAnonymousUser() async {
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
