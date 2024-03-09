import 'package:beatboks/firebase_service.dart';
import 'package:beatboks/navigation/navigation.dart';
import 'package:beatboks/state/spinner_signal.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class SignoutBottomSheet extends StatefulWidget {
  const SignoutBottomSheet({super.key});

  @override
  State<SignoutBottomSheet> createState() {
    return _SignoutBottomSheetState();
  }
}

class _SignoutBottomSheetState extends State<SignoutBottomSheet> {
  final FirebaseService _firebase = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Sign out',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            const Text('Are you sure you want to sign out?'),
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

                    // Sign out the user.
                    _firebase.signOut(
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

                        // Navigate to the StartScreen.
                        Navigate.toStartScreen(context);

                        // Show a SnackBar.
                        Snacks.showSuccessSnack(
                          context,
                          'You have been signed out.',
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
