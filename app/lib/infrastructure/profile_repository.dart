import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/domain/profile_model.dart';

Stream<Profile> streamProfile(String id) {
  return Supabase.instance.client
      .from('profiles')
      .stream(primaryKey: ['id'])
      .eq('id', id)
      .limit(1)
      .map((data) => Profile.fromJson(data.first));
}

Future<Profile> fetch(String userId) async {
  final json =
      await Supabase.instance.client
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
      await Supabase.instance.client
          .from('profiles')
          .update(updates)
          .eq('id', userId)
          .select()
          .single();
  return Profile.fromJson(json);
}

Future<Profile> createAndJoinGame() async {
  final response = await Supabase.instance.client.functions.invoke(
    'create-and-join-game',
  );
  return Profile.fromJson(response.data);
}

Future<Profile> joinGame(String gameId) async {
  final response = await Supabase.instance.client.functions.invoke(
    'join-game',
    body: {'id': gameId},
  );
  return Profile.fromJson(response.data);
}
