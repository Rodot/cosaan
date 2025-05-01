import 'package:flutter/material.dart';
import 'package:app/presentation/components/profile_name_field.dart';
import 'package:app/presentation/components/game_management_buttons.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileNameField(),
        SizedBox(height: 16.0),
        GameManagementButtons(),
      ],
    );
  }
}
