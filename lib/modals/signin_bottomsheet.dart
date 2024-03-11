import 'package:beatboks/firebase/firebase_service.dart';
import 'package:beatboks/firebase/firestore_service.dart';
import 'package:beatboks/navigation/navigation.dart';
import 'package:beatboks/state/spinner_signal.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class SigninBottomSheet extends StatefulWidget {
  const SigninBottomSheet({
    super.key,
  });

  @override
  State<SigninBottomSheet> createState() {
    return _SigninBottomSheet();
  }
}

class _SigninBottomSheet extends State<SigninBottomSheet> {
  final FirebaseService _firebase = FirebaseService();
  final FirestoreService _firestore = FirestoreService();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              title: 'Sign in to your account',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                icon: FaIcon(FontAwesomeIcons.solidEnvelope),
                labelText: 'Email',
              ),
            ).animate().fade().moveX(delay: 200.ms),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: _isObscured,
              decoration: InputDecoration(
                icon: const FaIcon(FontAwesomeIcons.lock),
                labelText: 'Password',
                suffixIcon: TextButton(
                  onPressed: () {
                    // Toggle the obscureText property.
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                  child: _isObscured ? const Text('SHOW') : const Text('HIDE'),
                ),
              ),
            ).animate().fade(delay: 200.ms).moveX(delay: 400.ms),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Show the ResetPasswordBottomSheet.
              },
              child: const Text('FORGOT PASSWORD'),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Cancel the spinner.
                    sSpinner.value = false;

                    // Pop the bottomsheet.
                    Navigator.of(context).pop();
                  },
                  child: const Text('CANCEL'),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // Start the spinner.
                    sSpinner.value = true;

                    // Sign in the user.
                    _firebase.signIn(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      onError: (String error) {
                        // Cancel the spinner.
                        sSpinner.value = false;

                        // Show a SnackBar.
                        Snacks.showErrorSnack(context, error);
                      },
                      onSuccess: () {
                        // Fetch the user doc from Firestore.
                        _firestore.fetchUserDoc(
                          onError: (String error) {
                            // Show a SnackBar.
                            Snacks.showErrorSnack(context, error);
                          },
                          onSuccess: () {
                            // Show a SnackBar.
                            Snacks.showSuccessSnack(
                              context,
                              'User data retrieved!',
                            );
                          },
                        );

                        // Cancel the spinner.
                        sSpinner.value = false;

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
                  // Show a spinner or icon.
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
