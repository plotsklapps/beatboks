import 'package:beatboks/navigation/navigation.dart';
import 'package:beatboks/providers/firebase_provider.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsBottomSheet extends ConsumerWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Settings',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 32),
            ListTile(
              onTap: () {
                // Log out the user.
                ref.read(firebaseProvider.notifier).signOut(
                  onError: (String error) {
                    Snacks.showErrorSnack(context, error);
                  },
                  onSuccess: () {
                    Navigator.pop(context);
                    Navigate.toStartScreen(context);
                    Snacks.showSuccessSnack(
                      context,
                      'You have successfully signed out',
                    );
                  },
                );
              },
              title: const Text('Log out'),
              leading: const FaIcon(FontAwesomeIcons.rightFromBracket),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ),
          ],
        ),
      ),
    );
  }
}
