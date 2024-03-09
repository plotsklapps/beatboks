import 'package:beatboks/firebase_service.dart';
import 'package:beatboks/state/spinner_signal.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class PasswordBottomSheet extends StatefulWidget {
  const PasswordBottomSheet({super.key});

  @override
  State<PasswordBottomSheet> createState() {
    return _PasswordBottomSheetState();
  }
}

class _PasswordBottomSheetState extends State<PasswordBottomSheet> {
  final FirebaseService _firebase = FirebaseService();
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          MediaQuery.viewInsetsOf(context).bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Reset your password',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                icon: FaIcon(FontAwesomeIcons.solidEnvelope),
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ).animate().fade().moveX(delay: 200.ms),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Cancel the spinner.
                    sSpinner.value = false;

                    // Pop the bottomsheet.
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // Start the spinner.
                    sSpinner.value = true;

                    // Send the password reset email.
                    _firebase.updatePassword(
                      email: _emailController.text.trim(),
                      onError: (String error) {
                        // Cancel the spinner.
                        sSpinner.value = false;

                        // Show a SnackBar.
                        Snacks.showErrorSnack(context, error);
                      },
                      onSuccess: () {
                        // Cancel the spinner.
                        sSpinner.value = false;

                        // Pop the bottomsheet.
                        Navigator.pop(context);

                        // Show a SnackBar.
                        Snacks.showSuccessSnack(
                          context,
                          'Password reset email sent! Please check your inbox '
                          'and/or spamfolder.',
                        );
                      },
                    );
                  },
                  child: cSpinner.watch(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
