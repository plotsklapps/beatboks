import 'package:beatboks/modals/displayname_bottomsheet.dart';
import 'package:beatboks/modals/signout_bottomsheet.dart';
import 'package:beatboks/modals/theme_bottomsheet.dart';
import 'package:beatboks/state/sneakpeek_signal.dart';
import 'package:beatboks/state/thememode_signal.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
                if (sSneakPeek.value) {
                  // Show a SnackBar.
                  Snacks.showErrorSnack(
                    context,
                    'You are a Sneak Peeker. You cannot change your '
                    'username.',
                  );
                  return;
                }
                // Show the DisplayNameBottomsheet.
                showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const DisplayNameBottomsheet();
                  },
                );
              },
              title: const Text('Change username'),
              leading: const SizedBox(
                width: 40,
                child: FaIcon(FontAwesomeIcons.userPen),
              ),
            ).animate().fade().moveX(delay: 200.ms),
            ListTile(
              onTap: () {
                // Show the SignoutBottomSheet
                showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const ThemeBottomSheet();
                  },
                );
              },
              title: const Text('Change theme'),
              leading: SizedBox(
                width: 40,
                child: cThemeModeIcon.watch(context),
              ),
            ).animate().fade(delay: 200.ms).moveX(delay: 400.ms),
            ListTile(
              onTap: () {
                // Show the SignoutBottomSheet
                showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const SignoutBottomSheet();
                  },
                );
              },
              title: const Text('Log out'),
              leading: const SizedBox(
                width: 40,
                child: FaIcon(FontAwesomeIcons.rightFromBracket),
              ),
            ).animate().fade(delay: 400.ms).moveX(delay: 600.ms),
          ],
        ),
      ),
    );
  }
}
