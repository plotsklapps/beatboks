import 'package:beatboks/navigation/navigation.dart';
import 'package:beatboks/providers/firebase_provider.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SigninBottomSheet extends ConsumerStatefulWidget {
  const SigninBottomSheet({
    super.key,
  });

  @override
  ConsumerState<SigninBottomSheet> createState() {
    return _SigninBottomSheet();
  }
}

class _SigninBottomSheet extends ConsumerState<SigninBottomSheet> {
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
                    Navigator.of(context).pop();
                  },
                  child: const Text('CANCEL'),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // Sign in user.
                    ref.read(firebaseProvider.notifier).signIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                          onError: (String error) {
                            Snacks.showErrorSnack(context, error);
                          },
                          onSuccess: () {
                            Navigator.pop(context);
                            Navigate.toHomeScreen(context);
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
