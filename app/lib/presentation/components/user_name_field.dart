import 'package:flutter/material.dart';
import 'package:app/domain/models/user.dart';

class UserNameField extends StatefulWidget {
  final UserProfile? userProfile;
  final Function(UserProfile) onUpdateRequested;

  const UserNameField({
    super.key,
    required this.userProfile,
    required this.onUpdateRequested,
  });

  @override
  State<UserNameField> createState() => _UserNameFieldState();
}

class _UserNameFieldState extends State<UserNameField> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.userProfile?.name != null) {
      _nameController.text = widget.userProfile!.name!;
    }
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
    if (widget.userProfile?.name != oldWidget.userProfile?.name && 
        widget.userProfile?.name != null) {
      _nameController.text = widget.userProfile!.name!;
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
                _nameController.text.trim() == (widget.userProfile?.name ?? '')
                    ? null
                    : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.red),
                          onPressed: () {
                            // Discard changes and restore original username
                            if (widget.userProfile?.name != null) {
                              _nameController.text = widget.userProfile!.name!;
                            } else {
                              _nameController.clear();
                            }
                          },
                          tooltip: 'Discard changes',
                        ),
                        IconButton(
                          icon: const Icon(Icons.save),
                          onPressed: () {
                            final trimmedValue = _nameController.text.trim();
                            if (trimmedValue.isNotEmpty && widget.userProfile != null) {
                              final updatedProfile = widget.userProfile!.copyWith(
                                name: trimmedValue,
                              );
                              widget.onUpdateRequested(updatedProfile);
                            }
                          },
                          tooltip: 'Save changes',
                        ),
                      ],
                    ),
          ),
          onSubmitted: (value) {
            final trimmedValue = value.trim();
            if (trimmedValue.isNotEmpty && 
                trimmedValue != widget.userProfile?.name && 
                widget.userProfile != null) {
              final updatedProfile = widget.userProfile!.copyWith(
                name: trimmedValue,
              );
              widget.onUpdateRequested(updatedProfile);
            }
          },
        ),
      ],
    );
  }
}
