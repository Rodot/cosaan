import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onPressed(BuildContext context) {
    context.go('/create');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Welcome to the Game!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => onPressed(context),
          child: Text("Create Game"),
        ),
      ],
    );
  }
}
