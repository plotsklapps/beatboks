import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerifyBottomSheet extends StatelessWidget {
  const VerifyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
              'We have sent a verification email to your email address. '
              'Please verify your email to continue. We might end up in your '
              'spam folder.',
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
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
