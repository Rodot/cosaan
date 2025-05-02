import 'package:app/presentation/components/game_join_button.dart';
import 'package:flutter/material.dart';
import 'package:app/presentation/components/profile_name_field.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key, required this.gameId});
  final String gameId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileNameField(),
        SizedBox(height: 16.0),
        GameJoinButton(gameId: gameId),
      ],
    );
  }
}
