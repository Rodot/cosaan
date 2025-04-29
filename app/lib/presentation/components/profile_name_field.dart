import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/domain/models/profile.dart';
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
        data: (profile) => _buildNameField(context, ref, profile),
        loading: () => _buildDisabledTextField(),
        error: (error, stackTrace) {
          showErrorSnackbar(context, error.toString());
          return _buildDisabledTextField();
        },
      ),
    );
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

  Widget _buildNameField(BuildContext context, WidgetRef ref, Profile profile) {
    final textController = TextEditingController(text: profile.name ?? '');
    
    return StatefulBuilder(
      builder: (context, setState) {
        textController.addListener(() {
          // Force rebuild when text changes
          setState(() {});
        });
        
        return TextField(
          controller: textController,
          decoration: InputDecoration(
            labelText: 'Your Name',
            border: const OutlineInputBorder(),
            suffixIcon: _buildButtons(textController, profile, ref, setState),
          ),
          onSubmitted: (value) => _updateProfileName(value, profile, ref),
        );
      }
    );
  }

  Widget? _buildButtons(
    TextEditingController controller, 
    Profile profile, 
    WidgetRef ref,
    Function(Function()) setState,
  ) {
    final isModified = controller.text.trim() != (profile.name ?? '');
    if (!isModified) return null;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildClearButton(controller, profile),
        _buildSaveButton(controller, profile, ref),
      ],
    );
  }
  
  Widget _buildClearButton(
    TextEditingController controller,
    Profile profile,
  ) {
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        controller.text = profile.name ?? '';
      },
      tooltip: 'Discard changes',
    );
  }
  
  Widget _buildSaveButton(
    TextEditingController controller,
    Profile profile,
    WidgetRef ref,
  ) {
    return IconButton(
      icon: const Icon(Icons.save),
      onPressed: () {
        final updatedProfile = profile.copyWith(
          name: controller.text.trim(),
        );
        ref
            .read(profileNotifierProvider.notifier)
            .updateProfile(updatedProfile);
      },
      tooltip: 'Save changes',
    );
  }

  void _updateProfileName(String value, Profile profile, WidgetRef ref) {
    final trimmedValue = value.trim();
    if (trimmedValue.isNotEmpty && trimmedValue != profile.name) {
      final updatedProfile = profile.copyWith(name: trimmedValue);
      ref.read(profileNotifierProvider.notifier).updateProfile(updatedProfile);
    }
  }
}