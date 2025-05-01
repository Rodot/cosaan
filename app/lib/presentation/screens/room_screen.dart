import 'package:flutter/material.dart';
import 'package:app/presentation/components/profile_name_field.dart';
import 'package:app/presentation/components/room_logs.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen(this.roomId, {super.key});
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            ProfileNameField(),
            SizedBox(height: 16.0),
            Expanded(child: RoomLogs(roomId)),
          ],
        ),
      ),
    );
  }
}
