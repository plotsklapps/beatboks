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
]);

final ListSignal<Song> sCheckedSongList = listSignal(<Song>[]);
