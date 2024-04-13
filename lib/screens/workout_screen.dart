import 'package:beatboks/song_class.dart';
import 'package:beatboks/state/photoURL_signal.dart';
import 'package:beatboks/state/songlist_signal.dart';
import 'package:beatboks/theme/text_utils.dart';
import 'package:beatboks/widgets/snackbars.dart';
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

      await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: playList),
      );
    } catch (e) {
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
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: sCheckedSongList.watch(context).length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: IconButton(
                              icon: const FaIcon(FontAwesomeIcons.volumeHigh),
                              onPressed: () {
                                // Implement play functionality
                              },
                            ),
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
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.circlePlay,
                              size: 48,
                            ),
                            onPressed: () async {
                              if (sCheckedSongList.watch(context).isEmpty) {
                                Snacks.showErrorSnack(
                                  context,
                                  'Please add some songs first, we recommend 3-8 songs for a solid workout!',
                                );
                              } else {
                                // Play the playList that was set in the initState.
                                if (sIsPlaying.value == true) {
                                  await _audioPlayer.pause();
                                } else {
                                  try {
                                    await _audioPlayer.play();
                                  } catch (e) {
                                    Logger().e('Error: $e');
                                  }
                                }
                              }
                            },
                          ),
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.forwardStep,
                              size: 32,
                            ),
                            onPressed: () {
                              // Implement skipping to next track
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
            ],
          ),
        ),
      ),
    );
  }
}
