import 'package:beatboks/modals/signup_bottomsheet.dart';
import 'package:beatboks/theme/theme.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StartScreenBottomSheet extends StatelessWidget {
  const StartScreenBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
              onTap: () {},
              leading: const FaIcon(FontAwesomeIcons.userCheck),
              title: const Text(
                'Use an existing account',
                style: TextUtils.fontL,
              ),
              subtitle: const Text("You've already used beatBOKS "
                  'before and want to sign in'),
            ).animate().fade(delay: 200.ms).moveX(delay: 400.ms),
            ListTile(
              onTap: () {},
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
