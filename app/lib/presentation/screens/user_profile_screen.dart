import 'package:app/presentation/utils/show_error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/user_profile_provider.dart';
import 'package:app/presentation/components/user_name_field.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileNotifierProvider);

    return userProfileAsync.when(
      data: (userProfile) {
        return UserNameField(
          userProfile: userProfile,
          updateUserProfile:
              ref.read(userProfileNotifierProvider.notifier).updateUserProfile,
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) {
        showErrorSnackbar(context, error.toString());
        return const Text('Error loading profile');
      },
    );
  }
}
