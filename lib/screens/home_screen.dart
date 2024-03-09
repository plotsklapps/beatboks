import 'package:beatboks/widgets/bottomsheetheader.dart';
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
                    return const SizedBox(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            BottomSheetHeader(
                              title: 'Settings',
                            ),
                            Divider(thickness: 2),
                            SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ListTile(
                                  title: Text('Log out'),
                                  leading:
                                      FaIcon(FontAwesomeIcons.rightFromBracket),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
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
