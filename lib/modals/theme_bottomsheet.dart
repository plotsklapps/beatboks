import 'package:beatboks/state/theme_signal.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
                sDarkMode.value = !sDarkMode.value;
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
                Snacks.showErrorSnack(
                    context,
                    'Feature coming soon, as soon '
                    'as I figure out how to watch(context) inside a global '
                    'variable.');
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
                Snacks.showErrorSnack(
                    context,
                    'Feature coming soon, as soon '
                    'as I figure out how to watch(context) inside a global '
                    'variable.');
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