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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
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
                  child: CustomCarousel(
                    itemCountBefore: 2,
                    itemCountAfter: 2,
                    loop: true,
                    scrollSpeed: 2,
                    alignment: Alignment.center,
                    effectsBuilder: CustomCarousel.effectsBuilderFromAnimate(
                      effects: EffectList()
                          .shimmer(
                            delay: 60.ms,
                            duration: 140.ms,
                            color: Colors.white38,
                            angle: 0.3,
                          )
                          .blurXY(delay: 0.ms, duration: 100.ms, begin: 8)
                          .blurXY(delay: 100.ms, end: 8)
                          .slideY(
                            delay: 0.ms,
                            duration: 200.ms,
                            begin: -3,
                            end: 3,
                          )
                          .flipH(begin: -0.3, end: 0.3),
                    ),
                    children: _songList(),
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

  List<Widget> _songList() {
    final List<Widget> songList = <Widget>[];
    for (int i = 0; i < sSongList.length; i++) {
      songList.add(
        SongCard(
          leadingIcon: FontAwesomeIcons.circlePlay,
          artist: sSongList[i].artist,
          title: sSongList[i].title,
          album: sSongList[i].album,
          year: sSongList[i].year,
          genre: sSongList[i].genre,
          duration: sSongList[i].duration,
          source: sSongList[i].source,
          isChecked: sSongList[i].isChecked,
          onPressed: () {
            sSongList[i].isChecked.value = !sSongList[i].isChecked.value;
            if (sSongList[i].isChecked.value == true) {
              sCheckedSongs.value++;
              sCheckedSongList.add(sSongList[i]);
            } else {
              sCheckedSongs.value--;
              sCheckedSongList.remove(sSongList[i]);
            }
          },
        ),
      );
    }
    return songList;
  }
}
