import 'package:beatboks/state/sneakpeek_signal.dart';
import 'package:beatboks/state/themecolor_signal.dart';
import 'package:beatboks/state/themefont_signal.dart';
import 'package:beatboks/state/thememode_signal.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Theme',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 32),
            ListTile(
              onTap: () {
                // Update the state.
                sDarkMode.value = !sDarkMode.value;

                if (!sSneakPeek.value) {
                  final User? user = FirebaseAuth.instance.currentUser;

                  // Update the firestore doc.
                  firestore
                      .collection('users')
                      .doc(user?.uid)
                      .update(<String, bool>{
                    'darkMode': sDarkMode.value,
                  });
                }
              },
              title: const Text('Change thememode'),
              leading: const SizedBox(
                width: 40,
                child: FaIcon(FontAwesomeIcons.circleHalfStroke),
              ),
              trailing: cThemeModeIcon.watch(context),
            ).animate().fade().moveX(delay: 200.ms),
            ListTile(
              onTap: () {
                // Update the state.
                sOuterSpace.value = !sOuterSpace.value;

                // TODO(plotsklapps): Update the firestore doc.
              },
              title: const Text('Change themecolor'),
              leading: const SizedBox(
                width: 40,
                child: FaIcon(FontAwesomeIcons.palette),
              ),
              trailing: cColorIcon.watch(context),
            ).animate().fade(delay: 200.ms).moveX(delay: 400.ms),
            ListTile(
              onTap: () {
                // Update the state.
                sTeko.value = !sTeko.value;

                // TODO(plotsklapps): Update the firestore doc.
              },
              title: const Text('Change font'),
              leading: const SizedBox(
                width: 40,
                child: FaIcon(FontAwesomeIcons.f),
              ),
              trailing: cFontIcon.watch(context),
            ).animate().fade(delay: 400.ms).moveX(delay: 600.ms),
          ],
        ),
      ),
    );
  }
}
