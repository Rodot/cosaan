import 'package:flutter/material.dart';
import 'package:app/domain/models/user.dart';

class UserNameField extends StatefulWidget {
  final Profile profile;
  final Function(Profile) updateProfile;

  const UserNameField({
    super.key,
    required this.profile,
    required this.updateProfile,
  });

  @override
  State<UserNameField> createState() => _UserNameFieldState();
}

class _UserNameFieldState extends State<UserNameField> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.profile.name ?? '';
    _nameController.addListener(() {
      setState(() {
        // This will rebuild the widget when text changes
      });
    });
  }

  @override
  void didUpdateWidget(UserNameField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update controller when userName changes from parent
    if (widget.profile.name != oldWidget.profile.name) {
      _nameController.text = widget.profile.name ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Your Name',
            border: const OutlineInputBorder(),
            suffixIcon:
                _nameController.text.trim() == (widget.profile.name ?? '')
                    ? null
                    : SaveAndDiscardButtons(
                      widget: widget,
                      nameController: _nameController,
                    ),
          ),
          onSubmitted: updateProfileName,
        ),
      ],
    );
  }

  void updateProfileName(value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isNotEmpty && trimmedValue != widget.profile.name) {
      final updatedProfile = widget.profile.copyWith(name: trimmedValue);
      widget.updateProfile(updatedProfile);
    }
  }
}

class SaveAndDiscardButtons extends StatelessWidget {
  const SaveAndDiscardButtons({
    super.key,
    required this.widget,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final UserNameField widget;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _nameController.text = widget.profile.name ?? '';
          },
          tooltip: 'Discard changes',
        ),
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            final updatedProfile = widget.profile.copyWith(
              name: _nameController.text,
            );
            widget.updateProfile(updatedProfile);
          },
          tooltip: 'Save changes',
        ),
      ],
    );
  }
}
