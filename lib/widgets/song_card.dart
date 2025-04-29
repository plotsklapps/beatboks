import 'package:beatboks/state/themecolor_signal.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:signals/signals_flutter.dart';

class SongCard extends StatefulWidget {
  const SongCard({
    required this.leadingIcon,
    required this.artist,
    required this.title,
    required this.album,
    required this.year,
    required this.genre,
    required this.duration,
    required this.source,
    required this.isChecked,
    required this.onPressed,
    super.key,
  });

  final IconData leadingIcon;
  final String artist;
  final String title;
  final String album;
  final String year;
  final String genre;
  final String duration;
  final String source;
  final Signal<bool> isChecked;
  final VoidCallback onPressed;

  @override
  State<SongCard> createState() {
    return _SongCardState();
  }
}

class _SongCardState extends State<SongCard> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Signal<bool> _sIsPlaying = signal<bool>(false);

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    // Set the asset to the player on initialization.
    // Widget title String corresponds to MP3 file name.
    try {
      await _audioPlayer.setAsset(
        'assets/MP3/${widget.artist} - ${widget.title}.mp3',
      );
    } on Exception catch (e) {
      Logger().e('Error: $e');
    }

    // playerState.playing returns a bool that is stored in the sIsPlaying
    // signal. This signal is then used to update the UI.
    _audioPlayer.playerStateStream.listen((PlayerState playerState) {
      if (playerState.processingState == ProcessingState.ready) {
        _sIsPlaying.value = playerState.playing;
      }
      if (playerState.processingState == ProcessingState.completed) {
        _sIsPlaying.value = false;
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
    return Card(
      color: widget.isChecked.value
          ? cColor.value == FlexScheme.outerSpace
              ? FlexColor.outerSpaceLightPrimaryContainer
              : FlexColor.moneyLightPrimaryContainer
          : null,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ExpansionTile(
          leading: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ShimmerImage(
                imagePath:
                    'assets/PNG/albumcovers/${widget.artist} - ${widget.title}.png',
              ),
              GestureDetector(
                onTap: () async {
                  if (_sIsPlaying.value == true) {
                    await _audioPlayer.pause();
                  } else {
                    try {
                      await _audioPlayer.play();
                    } on Exception catch (e) {
                      Logger().e('Error: $e');
                    }
                  }
                },
                child: _sIsPlaying.watch(context)
                    ? const FaIcon(
                        FontAwesomeIcons.circlePause,
                        size: 24,
                      )
                    : const FaIcon(
                        FontAwesomeIcons.circlePlay,
                        size: 24,
                      ),
              ),
            ],
          ),
          title: Text(widget.artist),
          subtitle: Text(widget.title),
          trailing: IconButton(
            onPressed: widget.onPressed,
            icon: FaIcon(
              widget.isChecked.value
                  ? FontAwesomeIcons.circleCheck
                  : FontAwesomeIcons.circle,
            ),
          ),
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Artist'),
                    Text(widget.artist),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Title'),
                    Text(widget.title),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Album'),
                    Text(widget.album),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Year'),
                    Text(widget.year),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Genre'),
                    Text(widget.genre),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Duration'),
                    Text(widget.duration),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Source'),
                    Text(widget.source),
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

class ShimmerImage extends StatefulWidget {
  const ShimmerImage({
    required this.imagePath,
    super.key,
  });

  final String imagePath;

  @override
  ShimmerImageState createState() {
    return ShimmerImageState();
  }
}

class ShimmerImageState extends State<ShimmerImage> {
  bool _isImageLoaded = false;
  bool _isImagePreloadingStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isImagePreloadingStarted) {
      // Prevent the preload from running multiple times
      _isImagePreloadingStarted = true;
      // Start preloading the image
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    try {
      // Simulate a delay for debugging purposes
      await Future<void>.delayed(const Duration(seconds: 2));
      // Preload the image
      if (mounted) {
        await precacheImage(AssetImage(widget.imagePath), context);
      }
      if (mounted) {
        setState(() {
          _isImageLoaded = true;
        });
      }
    } on Exception catch (e) {
      Logger().e('Error loading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isImageLoaded) {
      // Show Shimmer effect while loading
      return Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    } else {
      // Show image when loaded
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 48,
          width: 48,
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
