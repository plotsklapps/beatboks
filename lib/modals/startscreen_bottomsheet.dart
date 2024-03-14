import 'package:beatboks/firebase/firebase_service.dart';
import 'package:beatboks/modals/signin_bottomsheet.dart';
import 'package:beatboks/modals/signup_bottomsheet.dart';
import 'package:beatboks/navigation/navigation.dart';
import 'package:beatboks/theme/text_utils.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StartScreenBottomSheet extends StatelessWidget {
  const StartScreenBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebase = FirebaseService();

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Choose a sign-in method'),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            ListTile(
              onTap: () {
                showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const SignupBottomSheet();
                  },
                );
              },
              leading: const FaIcon(FontAwesomeIcons.userPlus),
              title: const Text(
                'Create an account',
                style: TextUtils.fontL,
              ),
              subtitle: const Text('Get a personalized experience'
                  ' and save your statistics (recommended)'),
            ).animate().fade().moveX(delay: 200.ms),
            ListTile(
              onTap: () {
                showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const SigninBottomSheet();
                  },
                );
              },
              leading: const FaIcon(FontAwesomeIcons.userCheck),
              title: const Text(
                'Use an existing account',
                style: TextUtils.fontL,
              ),
              subtitle: const Text("You've already used beatBOKS "
                  'before and want to sign in'),
            ).animate().fade(delay: 200.ms).moveX(delay: 400.ms),
            ListTile(
              onTap: () async {
                await firebase.signInAnonymously(
                  onError: (String error) {
                    Snacks.showErrorSnack(context, error);
                  },
                  onSuccess: () {
                    // Pop the bottomsheet.
                    Navigator.pop(context);

                    // Navigate to HomeScreen.
                    Navigate.toHomeScreen(context);

                    // Show a SnackBar.
                    Snacks.showSuccessSnack(
                      context,
                      'You have signed in as Sneak Peeker, your data will NOT '
                      'be stored. Enjoy!',
                    );
                  },
                );
              },
              leading: const FaIcon(FontAwesomeIcons.userSecret),
              title: const Text(
                'Sneak peek',
                style: TextUtils.fontL,
              ),
              subtitle: const Text('Try out beatBOKS anonymously '
                  'without storing any data'),
            ).animate().fade(delay: 400.ms).moveX(delay: 600.ms),
          ],
        ),
      ),
    );
  }
}
