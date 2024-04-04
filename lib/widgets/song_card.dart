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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: GestureDetector(
            onTap: () async {
              if (sIsPlaying.value = true) {
                await audioPlayer.pause();
                sIsPlaying.value = false;
              } else {
                try {
                  await audioPlayer.setAsset('assets/audio/song.mp3');
                  await audioPlayer.play();
                  sIsPlaying.value = true;
                } catch (e) {
                  if (e is PlayerException) {
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
