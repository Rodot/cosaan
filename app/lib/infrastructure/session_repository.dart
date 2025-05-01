import 'package:supabase_flutter/supabase_flutter.dart';

Future<Session> getUserSession() async {
  if (Supabase.instance.client.auth.currentSession == null) {
    await Supabase.instance.client.auth.signInAnonymously();
  }
  return Supabase.instance.client.auth.currentSession!;
}
