import 'package:flutter/material.dart';
import 'package:app/domain/models/user.dart';

class UserNameField extends StatefulWidget {
  final UserProfile userProfile;
  final Function(UserProfile) updateUserProfile;

  const UserNameField({
    super.key,
    required this.userProfile,
    required this.updateUserProfile,
  });

  @override
  State<UserNameField> createState() => _UserNameFieldState();
}

class _UserNameFieldState extends State<UserNameField> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userProfile.name;
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
    if (widget.userProfile.name != oldWidget.userProfile.name) {
      _nameController.text = widget.userProfile.name;
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
                _nameController.text.trim() == widget.userProfile.name
                    ? null
                    : SaveAndDiscardButtons(
                      widget: widget,
                      nameController: _nameController,
                    ),
          ),
          onSubmitted: updateUserProfileName,
        ),
      ],
    );
  }

  void updateUserProfileName(value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isNotEmpty && trimmedValue != widget.userProfile.name) {
      final updatedProfile = widget.userProfile.copyWith(name: trimmedValue);
      widget.updateUserProfile(updatedProfile);
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
            _nameController.text = widget.userProfile.name;
          },
          tooltip: 'Discard changes',
        ),
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            final updatedProfile = widget.userProfile.copyWith(
              name: _nameController.text,
            );
            widget.updateUserProfile(updatedProfile);
          },
          tooltip: 'Save changes',
        ),
      ],
    );
  }
}
