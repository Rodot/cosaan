import 'package:flutter/material.dart';

class IntroductionCard extends StatelessWidget {
  const IntroductionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Welcome to Cosaan!",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
