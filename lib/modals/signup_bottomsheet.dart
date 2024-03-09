import 'package:beatboks/firebase_service.dart';
import 'package:beatboks/modals/verify_bottomsheet.dart';
import 'package:beatboks/state/spinner_signal.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class SignupBottomSheet extends StatefulWidget {
  const SignupBottomSheet({
    super.key,
  });

  @override
  State<SignupBottomSheet> createState() {
    return _SignupBottomSheetState();
  }
}

class _SignupBottomSheetState extends State<SignupBottomSheet> {
  final FirebaseService _firebase = FirebaseService();
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
              title: 'Create an account',
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

                    // Create user and send verification email.
                    _firebase.signUp(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
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

                        // Show the VerifyBottomSheet.
                        showModalBottomSheet<Widget>(
                          showDragHandle: true,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return const VerifyBottomSheet();
                          },
                        );

                        // Show a SnackBar.
                        Snacks.showSuccessSnack(
                            context,
                            'Account created! Please check '
                            '${_emailController.text.trim()} for the '
                            'verification email');
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
