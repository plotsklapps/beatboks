import 'package:beatboks/firebase/firebase_service.dart';
import 'package:beatboks/firebase/firestore_service.dart';
import 'package:beatboks/navigation/navigation.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerifyBottomSheet extends StatelessWidget {
  const VerifyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebase = FirebaseService();
    final FirestoreService firestore = FirestoreService();
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Verify your email',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            const Text(
              'Please check your email inbox and your spamfolder.',
            ),
            const Text('Continue AFTER verifying your email.'),
            const Text('This might take a minute...'),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    firebase.checkEmailVerified(
                      onError: (String error) {
                        // Show a SnackBar.
                        Snacks.showErrorSnack(context, error);
                      },
                      onSuccess: () {
                        // Create user doc in Firestore.
                        firestore.createUserDoc(
                          onError: (String error) {
                            // Show a SnackBar.
                            Snacks.showErrorSnack(context, error);
                          },
                          onSuccess: () {
                            // Show a SnackBar.
                            Snacks.showSuccessSnack(
                              context,
                              'Email verified, user document created!',
                            );
                          },
                        );

                        // Pop the bottomsheet.
                        Navigator.pop(context);

                        // Navigate to the HomeScreen.
                        Navigate.toHomeScreen(context);

                        // Show a SnackBar.
                        Snacks.showSuccessSnack(
                          context,
                          'Welcome to beatBOKS! Enjoy your workout!',
                        );
                      },
                    );
                  },
                  child: const FaIcon(FontAwesomeIcons.forwardStep),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
