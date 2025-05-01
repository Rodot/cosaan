import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/domain/profile_model.dart';

Future<Profile> fetch(String userId) async {
  final SupabaseClient client = Supabase.instance.client;

  final json =
      await client
          .from('profiles')
          .select('id, name, game_id, created_at')
          .eq('id', userId)
          .single();
  return Profile.fromJson(json);
}

Future<Profile> update(String userId, Profile updatedProfile) async {
  final SupabaseClient client = Supabase.instance.client;

  final updates = {
    'name': updatedProfile.name,
    'game_id': updatedProfile.gameId,
  };
  final json =
      await client
          .from('profiles')
          .update(updates)
          .eq('id', userId)
          .select()
          .single();
  return Profile.fromJson(json);
}

Future<void> createAndJoinGame() async {
  final SupabaseClient client = Supabase.instance.client;

  await client.functions.invoke('create-and-join-game');
}

Future<void> joinGame() async {
  final SupabaseClient client = Supabase.instance.client;

  await client.functions.invoke('create-and-join-game');
}

Future<Profile> signInAnonymously() async {
  final SupabaseClient client = Supabase.instance.client;

  final Session? session = client.auth.currentSession;
  return session != null ? fetchExistingUser(session) : createAnonymousUser();
}

Future<Profile> fetchExistingUser(Session session) async {
  return await fetch(session.user.id);
}

Future<Profile> createAnonymousUser() async {
  final SupabaseClient client = Supabase.instance.client;

  final response = await client.auth.signInAnonymously();
  final user = validateUserResponse(response);
  return await fetch(user.id);
}

User validateUserResponse(AuthResponse response) {
  final user = response.user;
  if (user == null) {
    throw Exception('Error signing in anonymously: No user found');
  }
  return user;
}
