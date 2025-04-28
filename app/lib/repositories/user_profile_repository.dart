import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/domain/models/user.dart';

/// Repository responsible for user-related data operations
class UserProfileRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<UserProfile?> fetch(String userId) async {
    try {
      final userData =
          await _client
              .from('user_profiles')
              .select('id, name, room_id, created_at')
              .eq('id', userId)
              .single();

      return UserProfile(
        id: userData['id'] as String,
        name: userData['name'] as String?,
        roomId: userData['room_id'] as String?,
        createdAt:
            userData['created_at'] != null
                ? DateTime.parse(userData['created_at'] as String)
                : null,
      );
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
      return null;
    }
  }

  /// Updates user profile in the database
  Future<UserProfile?> update(String userId, UserProfile updatedProfile) async {
    try {
      final updates = {
        'name': updatedProfile.name,
        'room_id': updatedProfile.roomId,
      };
      await _client.from('user_profiles').update(updates).eq('id', userId);
      return updatedProfile;
    } catch (e) {
      debugPrint('Error updating user profile: $e');
      throw Exception('Error updating user profile: $e');
    }
  }

  /// Signs in anonymously or returns existing session
  Future<UserProfile> signInAnonymously() async {
    try {
      // Check if there's an existing session
      final Session? session = _client.auth.currentSession;

      if (session != null) {
        // User is already signed in, fetch their profile
        final userProfile = await fetch(session.user.id);
        if (userProfile == null) {
          debugPrint('User profile not found for ID: ${session.user.id}');
          throw Exception('User profile not found');
        }
        debugPrint('User is already signed in with ID: ${session.user.id}');
        return userProfile;
      }

      // Sign in anonymously
      final response = await _client.auth.signInAnonymously();
      if (response.user != null) {
        final userProfile = await fetch(response.user!.id);
        debugPrint('Anonymous sign-in successful: ${response.user!.id}');
        if (userProfile == null) {
          debugPrint('User profile not found for ID: ${response.user!.id}');
          throw Exception('User profile not found');
        }
        return userProfile;
      }
    } catch (e) {
      throw Exception('Error signing in anonymously: $e');
    }
    throw Exception('Error signing in anonymously: No user found');
  }
}
