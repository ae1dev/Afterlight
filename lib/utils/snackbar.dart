import 'package:flutter/material.dart';

void handleSnackbar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).primaryColor,
    ),
  );
}
