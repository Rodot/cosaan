import 'package:app/presentation/components/game_create_button.dart';
import 'package:app/presentation/components/introduction_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntroductionCard(),
        const SizedBox(height: 16),
        GameCreateButton(),
      ],
    );
  }
}
