import 'dart:ui';

import 'package:beatboks/modals/settings_bottomsheet.dart';
import 'package:beatboks/state/checkedsongs_signal.dart';
import 'package:beatboks/state/displayname_signal.dart';
import 'package:beatboks/state/lastvisit_signal.dart';
import 'package:beatboks/theme/text_utils.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
                children: <Widget>[
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
                    ),
                  ),
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
                    ),
                  ),
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
                      InkWell(
                        onTap: () {
                          showModalBottomSheet<Widget>(
                            showDragHandle: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return const EminemBottomSheet();
                            },
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListTile(
                              leading:
                                  const FaIcon(FontAwesomeIcons.circlePlay),
                              title: const Text('Eminem - Till I Collapse'),
                              subtitle: const Text('TUTORIAL WORKOUT'),
                              trailing: IconButton(
                                onPressed: () {
                                  isEminemChecked.value =
                                      !isEminemChecked.value;
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
                        ).animate().fade().moveX(delay: 200.ms),
                      ),
                      InkWell(
                        onTap: () {
                          // Show a SnackBar.
                          Snacks.showErrorSnack(
                            context,
                            'This app is work in progress! Please check back soon.',
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListTile(
                              leading:
                                  const FaIcon(FontAwesomeIcons.circlePlay),
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
                        ).animate().fade(delay: 200.ms).moveX(delay: 400.ms),
                      ),
                      InkWell(
                        onTap: () {
                          // Show a SnackBar.
                          Snacks.showErrorSnack(
                            context,
                            'This app is work in progress! Please check back soon.',
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListTile(
                              leading:
                                  const FaIcon(FontAwesomeIcons.circlePlay),
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
                        ).animate().fade(delay: 400.ms).moveX(delay: 600.ms),
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

class EminemBottomSheet extends StatelessWidget {
  const EminemBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Song Details',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Artist'),
                Text('Eminem (feat. Nate Dogg)', style: TextUtils.fontL),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Songtitle'),
                Text('Till I Collapse', style: TextUtils.fontL),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Album'),
                Text('The Eminem Show', style: TextUtils.fontL),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Year'),
                Text('2002', style: TextUtils.fontL),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Genre'),
                Text('Hip Hop', style: TextUtils.fontL),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Duration'),
                Text('5:25', style: TextUtils.fontL),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    isEminemChecked.value = !isEminemChecked.value;

                    if (isEminemChecked.value == true) {
                      sCheckedSongs.value++;
                    } else {
                      sCheckedSongs.value--;
                    }

                    // Pop the bottomsheet.
                    Navigator.pop(context);

                    // Show a SnackBar.
                    Snacks.showSuccessSnack(
                      context,
                      'This song is added to your workout playlist',
                    );
                  },
                  child: const FaIcon(FontAwesomeIcons.plus),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
