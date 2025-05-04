import 'package:app/presentation/components/game_join_button.dart';
import 'package:app/presentation/components/introduction_card.dart';
import 'package:flutter/material.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen(this.gameId, {super.key});
  final String gameId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntroductionCard(),
        SizedBox(height: 16.0),
        GameJoinButton(gameId: gameId),
      ],
    );
  }
}
