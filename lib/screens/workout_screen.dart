import 'package:beatboks/song_class.dart';
import 'package:beatboks/state/photourl_signal.dart';
import 'package:beatboks/state/songlist_signal.dart';
import 'package:beatboks/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() {
    return _WorkoutScreenState();
  }
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Signal<bool> sIsPlaying = signal<bool>(false);
  final Signal<int> sCurrentSongIndex = signal<int>(0);

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    // Set the assets list to the player on initialization.
    try {
      final List<AudioSource> playList =
          sCheckedSongList.watch(context).map((Song song) {
        return AudioSource.asset(
          'assets/MP3/${song.artist} - ${song.title}.mp3',
        );
      }).toList();

      await _audioPlayer.setAudioSources(playList);
          } on Exception catch (e) {
      Logger().e('Error: $e');
    }

    // playerState.playing returns a bool that is stored in the sIsPlaying
    // signal. This signal is then used to update the UI.
    _audioPlayer.playerStateStream.listen((PlayerState playerState) {
      if (playerState.processingState == ProcessingState.ready) {
        sIsPlaying.value = playerState.playing;
      }
      if (playerState.processingState == ProcessingState.completed) {
        sIsPlaying.value = false;
      }
    });

    // Listen to the currentIndexStream to update the sCurrentSongIndex
    // signal, whenever the currently playing song changes.
    _audioPlayer.currentIndexStream.listen((int? currentIndex) {
      if (currentIndex != null) {
        sCurrentSongIndex.value = currentIndex;
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Image.asset(cPhotoURL.watch(context)!, height: 24),
              const SizedBox(width: 8),
              const Text('beatBOKS Workout'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: sCheckedSongList.watch(context).length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: sCurrentSongIndex.watch(context) == index
                        ? sIsPlaying.watch(context)
                            ? const FaIcon(
                                FontAwesomeIcons.volumeHigh,
                              )
                            : const FaIcon(
                                FontAwesomeIcons.volumeLow,
                              )
                        : null,
                    title: Text(sCheckedSongList[index].artist),
                    subtitle: Text(sCheckedSongList[index].title),
                    trailing: Text(
                      sCheckedSongList[index].duration,
                      style: TextUtils.fontL,
                    ),
                  );
                },
              ),
              const Divider(thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.backwardStep,
                      size: 32,
                    ),
                    onPressed: () {
                      // Skip to the beginning of the current
                      // track or skip to the previous track.
                      if (sCurrentSongIndex.value > 0) {
                        sCurrentSongIndex.value--;
                        _audioPlayer.seekToPrevious();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: sIsPlaying.watch(context)
                        ? const FaIcon(
                            FontAwesomeIcons.circlePause,
                            size: 48,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.circlePlay,
                            size: 48,
                          ),
                    onPressed: () async {
                      if (sIsPlaying.value == false) {
                        try {
                          sIsPlaying.value = true;
                          await _audioPlayer.play();
                        } on Exception catch (e) {
                          Logger().e('Error: $e');
                        }
                      } else {
                        sIsPlaying.value = false;
                        await _audioPlayer.pause();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.forwardStep,
                      size: 32,
                    ),
                    onPressed: () {
                      // Skip to the next track.
                      if (sCurrentSongIndex.value <
                          sCheckedSongList.watch(context).length - 1) {
                        sCurrentSongIndex.value++;
                        _audioPlayer.seekToNext();
                      }
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Slider(
                    value: 0,
                    onChanged: (double value) {
                      // Implement scroll control.
                    },
                  ),
                  Text(
                    cTotalDuration.value,
                    style: TextUtils.fontXL,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
