import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context, String error) {
  debugPrint('[RUNTIME_ERROR] $error');
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: $error')));
  });
}
