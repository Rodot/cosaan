import 'package:supabase_flutter/supabase_flutter.dart';

Future<Session> getCurrentSession() async {
  final auth = Supabase.instance.client.auth;
  if (auth.currentSession == null) {
    await auth.signInAnonymously();
  }
  return auth.currentSession!;
}
