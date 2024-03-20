import 'dart:ui';

import 'package:beatboks/modals/settings_bottomsheet.dart';
import 'package:beatboks/state/checkedsongs_signal.dart';
import 'package:beatboks/state/displayname_signal.dart';
import 'package:beatboks/state/lastvisit_signal.dart';
import 'package:beatboks/theme/text_utils.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

final Signal<bool> isEminemChecked = signal<bool>(false);
final Signal<bool> isKanyeChecked = signal<bool>(false);
final Signal<bool> isWolfChecked = signal<bool>(false);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            const FaIcon(FontAwesomeIcons.userLarge),
                            Text(cDisplayName.watch(context)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                      child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.barsProgress),
                          Text('Statistics'),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          const FaIcon(FontAwesomeIcons.calendarCheck),
                          Text(sLastVisit.watch(context)),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              const Divider(thickness: 2),
              ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                  scrollbars: false,
                  dragDevices: <PointerDeviceKind>{
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.trackpad,
                    PointerDeviceKind.stylus,
                    PointerDeviceKind.invertedStylus,
                  },
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: const FaIcon(FontAwesomeIcons.circlePlay),
                            title: const Text('Eminem - Till I Collapse'),
                            subtitle: const Text('TUTORIAL WORKOUT'),
                            trailing: IconButton(
                              onPressed: () {
                                isEminemChecked.value = !isEminemChecked.value;
                                if (isEminemChecked.value == true) {
                                  sCheckedSongs.value++;
                                } else {
                                  sCheckedSongs.value--;
                                }
                              },
                              icon: isEminemChecked.watch(context)
                                  ? const FaIcon(FontAwesomeIcons.circleCheck)
                                  : const FaIcon(FontAwesomeIcons.circle),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: const FaIcon(FontAwesomeIcons.circlePlay),
                            title: const Text('Kanye West - Power'),
                            subtitle: const Text('ALL DAY JABS'),
                            trailing: IconButton(
                              onPressed: () {
                                isKanyeChecked.value = !isKanyeChecked.value;
                                if (isKanyeChecked.value == true) {
                                  sCheckedSongs.value++;
                                } else {
                                  sCheckedSongs.value--;
                                }
                              },
                              icon: isKanyeChecked.watch(context)
                                  ? const FaIcon(FontAwesomeIcons.circleCheck)
                                  : const FaIcon(FontAwesomeIcons.circle),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: const FaIcon(FontAwesomeIcons.circlePlay),
                            title: const Text('Masked Wolf - Astronaut In The'
                                ' Ocean'),
                            subtitle: const Text('HOOKS GALORE'),
                            trailing: IconButton(
                              onPressed: () {
                                isWolfChecked.value = !isWolfChecked.value;
                                if (isWolfChecked.value == true) {
                                  sCheckedSongs.value++;
                                } else {
                                  sCheckedSongs.value--;
                                }
                              },
                              icon: isWolfChecked.watch(context)
                                  ? const FaIcon(FontAwesomeIcons.circleCheck)
                                  : const FaIcon(FontAwesomeIcons.circle),
                            ),
                          ),
                        ),
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
            // Show a SnackBar.
            Snacks.showErrorSnack(
              context,
              'This app is work in progress! Please check back soon.',
            );
          },
          child: Text(
            sCheckedSongs.watch(context).toString(),
            style: TextUtils.fontXL,
          ),
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
                icon: const FaIcon(FontAwesomeIcons.gear),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
