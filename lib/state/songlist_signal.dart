import 'package:beatboks/song_class.dart';
import 'package:signals/signals.dart';

final Signal<int> sCheckedSongs = signal<int>(0);

final Signal<bool> isEminemChecked = signal<bool>(false);
final Signal<bool> isKanyeChecked = signal<bool>(false);
final Signal<bool> isWolfChecked = signal<bool>(false);

final ListSignal<Song> sSongList = listSignal(<Song>[
  Song(
    title: 'Eminem - Till I Collapse',
    subtitle: 'Duration - 5:37 min',
    isChecked: isEminemChecked,
  ),
  Song(
    title: 'Kanye West - POWER',
    subtitle: 'Duration - 0:00 min',
    isChecked: isKanyeChecked,
  ),
  Song(
    title: 'Masked Wolf - Astronaut In The Ocean',
    subtitle: 'Duration - 0:00 min',
    isChecked: isWolfChecked,
  ),
]);
