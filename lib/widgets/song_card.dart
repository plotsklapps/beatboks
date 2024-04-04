import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
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

  // In the initState method, we listen to the playerStateStream of the
  // audioPlayer. When the processingState of the player is
  // ProcessingState.ready, we update the sIsPlaying signal with the current
  // playing state of the player. This ensures that the sIsPlaying signal is
  // always in sync with the actual playing state of the player.
  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    try {
      await audioPlayer.setAsset('assets/MP3/eminem_tillicollapse.mp3');
    } catch (e) {
      if (e is PlayerException) {
        // Handle player exceptions.
        print('Error: ${e.message}');
      }
    }

    audioPlayer.playerStateStream.listen((PlayerState playerState) {
      if (playerState.processingState == ProcessingState.ready) {
        sIsPlaying.value = playerState.playing;
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: GestureDetector(
            onTap: () async {
              if (sIsPlaying.value == true) {
                await audioPlayer.pause();
              } else {
                try {
                  await audioPlayer.play();
                } catch (e) {
                  if (e is PlayerException) {
                    // TODO(plotsklapps): Handle player exceptions.
                    print('Error: ${e.message}');
                  }
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
        ),
      ),
    );
  }
}
