import 'package:beatboks/modals/verify_bottomsheet.dart';
import 'package:beatboks/providers/firebase_provider.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
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
          MediaQuery.viewInsetsOf(context).bottom + 16,
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
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                icon: FaIcon(FontAwesomeIcons.lock),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
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
                    // Create user and send verification email.
                    ref.read(firebaseProvider.notifier).signUp(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          onError: (String error) {
                            Snacks.showErrorSnack(context, error);
                          },
                          onSuccess: () {
                            Navigator.pop(context);
                            showModalBottomSheet<Widget>(
                              showDragHandle: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return const VerifyBottomSheet();
                              },
                            );
                            Snacks.showSuccessSnack(
                                context,
                                'Account created! Please check '
                                '${_emailController.text.trim()} for the '
                                'verification email');
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
