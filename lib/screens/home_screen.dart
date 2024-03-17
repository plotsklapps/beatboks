import 'package:beatboks/modals/settings_bottomsheet.dart';
import 'package:beatboks/state/displayname_signal.dart';
import 'package:beatboks/state/lastvisit_signal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          const FaIcon(FontAwesomeIcons.userNinja),
                          const SizedBox(height: 8),
                          // Watch the signal and display the value.
                          Text(cDisplayName.watch(context)),
                        ],
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.chartColumn),
                          SizedBox(height: 8),
                          Text('Statistics'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          const FaIcon(FontAwesomeIcons.calendarCheck),
                          const SizedBox(height: 8),
                          // Watch the signal and display the value.
                          Text(sLastVisit.watch(context)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        // TODO(plotsklapps): Create tutorial workout.
                      },
                      leading: const Column(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.headphonesSimple),
                          SizedBox(height: 4),
                          FaIcon(FontAwesomeIcons.circlePlay),
                        ],
                      ),
                      title: const Text('Eminem - Till I Collapse'),
                      subtitle: const Text('Tutorial Workout'),
                      trailing: const FaIcon(FontAwesomeIcons.forwardStep),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        // TODO(plotsklapps): Create first workout.
                      },
                      leading: const Column(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.headphonesSimple),
                          SizedBox(height: 4),
                          FaIcon(FontAwesomeIcons.circlePlay),
                        ],
                      ),
                      title: const Text('Kanye West - POWER'),
                      subtitle: const Text('Jab First'),
                      trailing: const FaIcon(FontAwesomeIcons.forwardStep),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        // TODO(plotsklapps): Create second workout.
                      },
                      leading: const Column(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.headphonesSimple),
                          SizedBox(height: 4),
                          FaIcon(FontAwesomeIcons.circlePlay),
                        ],
                      ),
                      title: const Text('Otherwise - Soldiers'),
                      subtitle: const Text('Hook Finish'),
                      trailing: const FaIcon(FontAwesomeIcons.forwardStep),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
