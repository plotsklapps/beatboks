import 'package:beatboks/firebase_provider.dart';
import 'package:beatboks/screens/home_screen.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

class SignupDialog extends ConsumerStatefulWidget {
  const SignupDialog({super.key});

  @override
  ConsumerState<SignupDialog> createState() {
    return _SignupDialogState();
  }
}

class _SignupDialogState extends ConsumerState<SignupDialog> {
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
    return AlertDialog(
      title: const Text('Create a beatBOKS account'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL'),
        ),
        FloatingActionButton(
          onPressed: () {
            ref.read(firebaseProvider.notifier).signUp(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                  onError: (String error) {
                    toastification.show(
                      context: context,
                      type: ToastificationType.error,
                      style: ToastificationStyle.flatColored,
                      description: Text(error),
                      alignment: Alignment.topRight,
                      autoCloseDuration: const Duration(seconds: 5),
                      icon: const FaIcon(FontAwesomeIcons.triangleExclamation),
                      borderRadius: BorderRadius.circular(12),
                      showProgressBar: true,
                      dragToClose: true,
                    );
                  },
                  onSuccess: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) {
                          return const HomeScreen();
                        },
                      ),
                    );
                    Snacks.showSuccessSnack(
                      'Account created successfully, please verify your email '
                      'address.',
                    );
                  },
                );
          },
          child: const FaIcon(FontAwesomeIcons.forwardStep),
        ),
      ],
    );
  }
}
