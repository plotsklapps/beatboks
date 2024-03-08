import 'package:beatboks/main.dart';
import 'package:beatboks/theme/theme.dart';
import 'package:flutter/material.dart';

class Snacks {
  static void showErrorSnack(String message) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: flexScheme.onError),
        ),
        showCloseIcon: true,
        backgroundColor: flexScheme.error,
      ),
    );
  }

  static void showSuccessSnack(String message) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        showCloseIcon: true,
      ),
    );
  }
}
