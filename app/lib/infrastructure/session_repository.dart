import 'package:app/infrastructure/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<Session> getCurrentSession() async {
  final auth = Supabase.instance.client.auth;
  if (auth.currentSession == null) {
    debugPrint("No current session, signing in anonymously.");
    await auth.signInAnonymously();
  }
  try {
    final userId = auth.currentSession!.user.id;
    await fetch(userId);
  } catch (e) {
    debugPrint("Error fetching profile");
    if (e.toString().contains("The result contains 0 rows")) {
      debugPrint("Profile not found, re-signing in anonymously.");
      await auth.signInAnonymously();
    } else {
      rethrow;
    }
  }
  debugPrint("Signed in as ${auth.currentSession?.user.id}");
  return auth.currentSession!;
}
