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

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 70),
      child: profileAsync.when(
        data:
            (profile) => _buildNameField(
              context,
              profile.name ?? '',
              (newName) => _handleNameUpdate(newName, profile, ref),
            ),
        loading: () => _buildDisabledTextField(),
        error: (error, stackTrace) {
          showErrorSnackbar(context, error.toString());
          return _buildDisabledTextField();
        },
      ),
    );
  }

  void _handleNameUpdate(String newName, Profile profile, WidgetRef ref) {
    final trimmedName = newName.trim();
    if (trimmedName.isNotEmpty && trimmedName != profile.name) {
      final updatedProfile = profile.copyWith(name: trimmedName);
      ref.read(profileNotifierProvider.notifier).updateProfile(updatedProfile);
    }
  }

  Widget _buildDisabledTextField() {
    return const TextField(
      enabled: false,
      decoration: InputDecoration(
        labelText: 'Your Name',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildNameField(
    BuildContext context,
    String text,
    Function(String) onTextSave,
  ) {
    final textController = TextEditingController(text: text);

    return StatefulBuilder(
      builder: (context, setState) {
        textController.addListener(() {
          // Force rebuild when text changes
          setState(() {});
        });

        final isModified = textController.text.trim() != text;

        void onSave() {
          onTextSave(textController.text.trim());
        }

        void onDiscard() {
          textController.text = text;
        }

        return TextField(
          controller: textController,
          decoration: InputDecoration(
            labelText: 'Your Name',
            border: const OutlineInputBorder(),
            suffixIcon: isModified ? _buildButtons(onSave, onDiscard) : null,
          ),
          onSubmitted: onTextSave,
        );
      },
    );
  }

  Widget _buildButtons(VoidCallback onSave, VoidCallback onDiscard) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [_buildClearButton(onDiscard), _buildSaveButton(onSave)],
    );
  }

  Widget _buildClearButton(VoidCallback onDiscard) {
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: onDiscard,
      tooltip: 'Discard changes',
    );
  }

  Widget _buildSaveButton(VoidCallback onSave) {
    return IconButton(
      icon: const Icon(Icons.save),
      onPressed: onSave,
      tooltip: 'Save changes',
    );
  }
}
