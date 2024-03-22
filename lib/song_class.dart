import 'package:signals/signals.dart';

class Song {
  Song({
    required this.title,
    required this.subtitle,
    required this.isChecked,
  });

  final String title;
  final String subtitle;
  final Signal<bool> isChecked;
}
