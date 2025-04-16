import 'package:flutter/material.dart';

void handleSnackbar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).primaryColor,
    ),
  );
}
