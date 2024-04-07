import 'package:beatboks/song_class.dart';
import 'package:signals/signals.dart';

final Signal<int> sCheckedSongs = signal<int>(0);

final Signal<bool> isEminemChecked = signal<bool>(false);
final Signal<bool> isKanyeChecked = signal<bool>(false);
final Signal<bool> isWolfChecked = signal<bool>(false);

final ListSignal<Song> sSongList = listSignal(<Song>[
  Song(
    artist: 'Eminem (feat. Nate Dogg)',
    title: 'Till I Collapse',
    album: 'The Eminem Show',
    year: '2002',
    genre: 'Rap, Hiphop',
    duration: '5:37',
    source: 'hipstrumentals.com',
    isChecked: isEminemChecked,
  ),
  Song(
    artist: 'Kanye West',
    title: 'Power',
    album: 'My Beautiful Dark Twisted Fantasy',
    year: '2010',
    genre: 'Rap, Hiphop',
    duration: '4:51',
    source: 'hipstrumentals.com',
    isChecked: isKanyeChecked,
  ),
]);

final ListSignal<Song> sCheckedSongList = listSignal(<Song>[]);

// Function to calculate total duration of the checked songs.
String calculateTotalDuration(List<Song> songs) {
  final int totalSeconds = songs.fold(0, (int previousValue, Song song) {
    final List<String> parts = song.duration.split(':');
    final int minutes = int.parse(parts[0]);
    final int seconds = int.parse(parts[1]);
    return previousValue + (minutes * 60 + seconds);
  });

  final int finalMinutes = totalSeconds ~/ 60;
  final int finalSeconds = totalSeconds % 60;

  return '${finalMinutes.toString().padLeft(2, '0')}:${finalSeconds.toString().padLeft(2, '0')}';
}

// Computed signal that returns the String value of the total duration.
final Computed<String> cTotalDuration = computed<String>(
  () {
    return calculateTotalDuration(sCheckedSongList.value);
  },
);
