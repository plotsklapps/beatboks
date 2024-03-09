import 'package:beatboks/modals/signout_bottomsheet.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              leading: const FaIcon(FontAwesomeIcons.rightFromBracket),
            ),
          ],
        ),
      ),
    );
  }
}
