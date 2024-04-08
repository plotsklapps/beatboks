import 'package:beatboks/song_class.dart';
import 'package:beatboks/state/songlist_signal.dart';
import 'package:beatboks/theme/text_utils.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class SummaryBottomsheet extends StatefulWidget {
  const SummaryBottomsheet({super.key});

  @override
  State<SummaryBottomsheet> createState() {
    return _SummaryBottomsheetState();
  }
}

class _SummaryBottomsheetState extends State<SummaryBottomsheet> {
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
    Logger().i('Audio player disposed.');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Workout Summary',
            ),
            const Divider(thickness: 2),
            ListView.builder(
              shrinkWrap: true,
              itemCount: sCheckedSongList.watch(context).length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(sCheckedSongList[index].artist),
                  subtitle: Text(sCheckedSongList[index].title),
                  trailing: Text(
                    sCheckedSongList[index].duration,
                    style: TextUtils.fontL,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text(
                  'Total Duration',
                  style: TextUtils.fontXL,
                ),
                Text(
                  cTotalDuration.value,
                  style: TextUtils.fontXL,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () async {
                    if (sCheckedSongList.watch(context).isEmpty) {
                      Snacks.showErrorSnack(context,
                          'Please add some songs first, we recommend 3-8 songs for a solid workout!');
                    } else {
                      await _audioPlayer.play();
                    }
                  },
                  child: sIsPlaying.watch(context)
                      ? const FaIcon(FontAwesomeIcons.circlePause)
                      : const FaIcon(FontAwesomeIcons.forwardStep),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
