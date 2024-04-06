import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class SongCard extends StatefulWidget {
  const SongCard({
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.onPressed,
    super.key,
  });

  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Signal<bool> isChecked;
  final VoidCallback onPressed;

  @override
  State<SongCard> createState() {
    return _SongCardState();
  }
}

class _SongCardState extends State<SongCard> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final Signal<bool> sIsPlaying = signal<bool>(false);

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    // Set the asset to the player on initialization.
    // Widget title String corresponds to MP3 file name.
    try {
      await audioPlayer.setAsset('assets/MP3/${widget.title}.mp3');
    } catch (e) {
      Logger().e('Error: $e');
    }

    // playerState.playing returns a bool that is stored in the sIsPlaying
    // signal. This signal is used to update the UI when the player is playing
    // or paused.
    audioPlayer.playerStateStream.listen((PlayerState playerState) {
      if (playerState.processingState == ProcessingState.ready) {
        sIsPlaying.value = playerState.playing;
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    Logger().i('Audio player disposed.');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ExpansionTile(
          leading: GestureDetector(
            onTap: () async {
              if (sIsPlaying.value == true) {
                await audioPlayer.pause();
              } else {
                try {
                  await audioPlayer.play();
                } catch (e) {
                  Logger().e('Error: $e');
                }
              }
            },
            child: sIsPlaying.watch(context)
                ? const FaIcon(FontAwesomeIcons.circlePause)
                : FaIcon(widget.leadingIcon),
          ),
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
          trailing: IconButton(
            onPressed: widget.onPressed,
            icon: FaIcon(
              widget.isChecked.value
                  ? FontAwesomeIcons.circleCheck
                  : FontAwesomeIcons.circle,
            ),
          ),
          children: const <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Artist'),
                    Text('Eminem (feat. Nate Dogg)'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Songtitle'),
                    Text('Till I Collapse'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Album'),
                    Text('The Eminem Show'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Year'),
                    Text('2002'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Genre'),
                    Text('Rap, Hiphop'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Duration'),
                    Text('5:37'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Source'),
                    Text('hipstrumentals.com'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
