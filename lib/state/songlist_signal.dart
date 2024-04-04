import 'package:beatboks/song_class.dart';
import 'package:signals/signals.dart';

final Signal<int> sCheckedSongs = signal<int>(0);

final Signal<bool> isEminemChecked = signal<bool>(false);
final Signal<bool> isKanyeChecked = signal<bool>(false);
final Signal<bool> isWolfChecked = signal<bool>(false);

final ListSignal<Song> sSongList = listSignal(<Song>[
  Song(
    title: 'Eminem (feat. Nate Dogg) - Till I Collapse',
    subtitle: 'TUTORIAL WORKOUT',
    isChecked: isEminemChecked,
  ),
  Song(
    title: 'Kanye West - POWER',
    subtitle: 'ALL DAY JABS',
    isChecked: isKanyeChecked,
  ),
  Song(
    title: 'Masked Wolf - Astronaut In The Ocean',
    subtitle: 'HOOKS GALORE',
    isChecked: isWolfChecked,
  ),
]);
