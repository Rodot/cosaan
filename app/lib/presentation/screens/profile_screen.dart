import 'package:flutter/material.dart';
import 'package:app/presentation/components/profile_name_field.dart';
import 'package:app/presentation/components/room_management_buttons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 80, child: ProfileNameField()),
            const SizedBox(height: 40),
            const SizedBox(height: 100, child: RoomManagementButtons()),
          ],
        ),
      ),
    );
  }
}
