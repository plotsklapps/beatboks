import 'package:beatboks/modals/startscreen_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/GIF/littleBoxer.gif'),
                const Text(
                  'beat',
                  style: TextStyle(fontSize: 42),
                ).animate().fade(delay: 400.ms).scale(delay: 600.ms),
                const Text(
                  'BOKS',
                  style: TextStyle(
                    fontSize: 54,
                  ),
                ).animate().fade(delay: 800.ms).scale(delay: 1000.ms),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<Widget>(
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const StartScreenBottomSheet();
            },
          );
        },
        tooltip: 'Continue',
        child: const FaIcon(FontAwesomeIcons.forwardStep),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
      ),
    );
  }
}
