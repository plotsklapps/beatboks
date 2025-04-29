import 'package:beatboks/song_class.dart';
import 'package:signals/signals.dart';

// Signal that counts the number of checked songs for use in the FAB.
final Signal<int> sCheckedSongs = signal<int>(0);

final Signal<bool> isTutorialChecked = signal<bool>(false);
final Signal<bool> isEminemChecked = signal<bool>(false);
final Signal<bool> isKanyeChecked = signal<bool>(false);
final Signal<bool> isCiaraChecked = signal<bool>(false);
final Signal<bool> isMaskedWolfChecked = signal<bool>(false);
final Signal<bool> isMacklemoreChecked = signal<bool>(false);
final Signal<bool> is2PacChecked = signal<bool>(false);

// Separate Song signal because this can be checked on/off by the user.
final Signal<Song> sTutorialSong = signal<Song>(
  Song(
    artist: 'BeatBOKS',
    title: 'Tutorial',
    album: 'BeatBOKS Tutorials',
    year: '2024',
    genre: 'Tutorial',
    duration: '1:22',
    source: 'beatboks.app',
    isChecked: isTutorialChecked,
  ),
);

// ListSignal for the list of songs. Every new song that's added to this list
// automatically updates other signals that are dependent on it.
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
  Song(
    artist: 'Ciara',
    title: 'Level Up',
    album: 'Beauty Marks',
    year: '2018',
    genre: 'Pop, Dance',
    duration: '3:23',
    source: 'hipstrumentals.com',
    isChecked: isCiaraChecked,
  ),
  Song(
    artist: 'Masked Wolf',
    title: 'Astronaut In The Ocean',
    album: 'Astronomical',
    year: '2021',
    genre: 'Pop, Rap',
    duration: '2:13',
    source: 'hipstrumentals.com',
    isChecked: isMaskedWolfChecked,
  ),
  Song(
    artist: 'Macklemore (feat. Ryan Lewis)',
    title: 'Cant Hold Us',
    album: 'The Heist',
    year: '2012',
    genre: 'Pop, Hiphop',
    duration: '4:19',
    source: 'hipstrumentals.com',
    isChecked: isMacklemoreChecked,
  ),
  Song(
    artist: '2Pac',
    title: 'Changes',
    album: 'Greatest Hits',
    year: '1998',
    genre: 'Rap, Hiphop',
    duration: '4:29',
    source: 'hipstrumentals.com',
    isChecked: is2PacChecked,
  ),
]);

// ListSignal for the list of checked songs. Index 0 can be a first song or
// the tutorial, dependant on the user's choice.
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

  return '${finalMinutes.toString().padLeft(2, '0')}:'
  '${finalSeconds.toString().padLeft(2, '0')}';
}

// Computed signal that returns the String value of the total duration.
final Computed<String> cTotalDuration = computed<String>(
  () {
    return calculateTotalDuration(sCheckedSongList.value);
  },
);
