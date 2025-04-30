import 'package:app/presentation/components/text_field_with_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/domain/profile_model.dart';
import 'package:app/presentation/state/profile_provider.dart';
import 'package:app/presentation/utils/show_error_snackbar.dart';

class ProfileNameField extends ConsumerWidget {
  const ProfileNameField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileNotifierProvider);

    return profileAsync.when(
      data: (profile) {
        return TextFieldWithSaveButton(
          value: profile.name ?? '',
          onSave: (newName) => _handleProfileUpdate(newName, profile, ref),
        );
      },
      loading:
          () => TextFieldWithSaveButton(
            value: profileAsync.value?.name,
            isLoading: true,
          ),
      error: (error, stackTrace) {
        showErrorSnackbar(context, error.toString());
        return TextFieldWithSaveButton();
      },
    );
  }

  void _handleProfileUpdate(String newName, Profile profile, WidgetRef ref) {
    final trimmedName = newName.trim();
    if (trimmedName.isNotEmpty && trimmedName != profile.name) {
      final updatedProfile = profile.copyWith(name: trimmedName);
      ref.read(profileNotifierProvider.notifier).updateProfile(updatedProfile);
    }
  }
}
