import 'package:flutter/material.dart';
import 'package:app/presentation/components/profile_name_field.dart';
import 'package:app/presentation/components/room_management_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileNameField(),
        SizedBox(height: 16.0),
        RoomManagementButtons(),
      ],
    );
  }
}
