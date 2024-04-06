import 'package:signals/signals.dart';

class Song {
  Song({
    required this.artist,
    required this.title,
    required this.album,
    required this.year,
    required this.genre,
    required this.duration,
    required this.source,
    required this.isChecked,
  });

  final String artist;
  final String title;
  final String album;
  final String year;
  final String genre;
  final String duration;
  final String source;
  final Signal<bool> isChecked;
}
