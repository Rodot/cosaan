import 'package:app/presentation/utils/show_error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_provider.dart';
import 'package:app/presentation/components/user_name_field.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileNotifierProvider);

    return profileAsync.when(
      data: (profile) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserNameField(
              profile: profile,
              updateProfile:
                  ref.read(profileNotifierProvider.notifier).updateProfile,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  (profile.name?.length ?? 0) == 0
                      ? null
                      : () {
                        ref.read(profileNotifierProvider.notifier).joinRoom();
                      },
              child: const Text('Create Game'),
            ),
            if (profile.roomId != null) ...[
              const SizedBox(height: 10),
              Text('Current Room: ${profile.roomId}'),
            ],
          ],
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
