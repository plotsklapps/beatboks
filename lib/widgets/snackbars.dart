import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

class Snacks {
  static void showErrorSnack(BuildContext context, String error) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: const Text('ERROR'),
      description: Text(error),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 5),
      icon: const FaIcon(
        FontAwesomeIcons.triangleExclamation,
      ),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
      dragToClose: true,
    );
  }

  static void showSuccessSnack(BuildContext context, String message) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: const Text('SUCCESS!'),
      description: Text(message),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 5),
      icon: const FaIcon(
        FontAwesomeIcons.circleCheck,
      ),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
      dragToClose: true,
    );
  }
}
