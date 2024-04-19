import 'dart:ui';

import 'package:beatboks/modals/settings_bottomsheet.dart';
import 'package:beatboks/modals/summary_bottomsheet.dart';
import 'package:beatboks/state/displayname_signal.dart';
import 'package:beatboks/state/lastvisit_signal.dart';
import 'package:beatboks/state/photourl_signal.dart';
import 'package:beatboks/state/songlist_signal.dart';
import 'package:beatboks/theme/text_utils.dart';
import 'package:beatboks/widgets/song_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                            Image.asset(
                              cPhotoURL.watch(context)!,
                              height: 24,
                            ),
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
                child: Expanded(
                  child: ListView.builder(
                    itemCount: sSongList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SongCard(
                        leadingIcon: FontAwesomeIcons.circlePlay,
                        artist: sSongList[index].artist,
                        title: sSongList[index].title,
                        album: sSongList[index].album,
                        year: sSongList[index].year,
                        genre: sSongList[index].genre,
                        duration: sSongList[index].duration,
                        source: sSongList[index].source,
                        isChecked: sSongList[index].isChecked,
                        onPressed: () {
                          sSongList[index].isChecked.value =
                              !sSongList[index].isChecked.value;
                          if (sSongList[index].isChecked.value == true) {
                            sCheckedSongs.value++;
                            sCheckedSongList.add(sSongList[index]);
                          } else {
                            sCheckedSongs.value--;
                            sCheckedSongList.remove(sSongList[index]);
                          }
                        },
                      );
                    },
                  ),
                ),
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
                return const SummaryBottomsheet();
              },
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
