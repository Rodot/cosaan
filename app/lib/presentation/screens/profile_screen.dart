import 'package:flutter/material.dart';
import 'package:app/presentation/components/profile_name_field.dart';
import 'package:app/presentation/components/room_management_buttons.dart';
import 'package:app/presentation/components/room_logs.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            ProfileNameField(),
            SizedBox(height: 16.0),
            RoomManagementButtons(),
            SizedBox(height: 16.0),
            Expanded(child: RoomLogs()),
          ],
        ),
      ),
    );
  }
}
