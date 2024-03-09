import 'package:beatboks/modals/settings_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Welcome to the home screen!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the StartScreen.
          Navigator.pop(context);
        },
        child: const FaIcon(FontAwesomeIcons.forwardStep),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const SettingsBottomSheet();
                  },
                );
              },
              icon: const FaIcon(FontAwesomeIcons.bars),
            ),
          ],
        ),
      ),
    );
  }
}
