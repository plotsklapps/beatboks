import 'package:beatboks/state/sneakpeek_signal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals/signals.dart';

// Signal for the photoURL. If user has not set their photoURL yet,
// it will return an empty String.
final Signal<String?> sPhotoURL = signal<String?>(
  FirebaseAuth.instance.currentUser?.photoURL ?? 'assets/PNG/punches/1.png',
);

// Signal for the photoURL avatar list.
final ListSignal<String> sPhotoURLList = listSignal<String>(<String>[
  'assets/PNG/punches/1.png',
  'assets/PNG/punches/2.png',
  'assets/PNG/punches/3.png',
  'assets/PNG/punches/4.png',
  'assets/PNG/punches/5.png',
  'assets/PNG/punches/6.png',
  'assets/PNG/punches/1B.png',
  'assets/PNG/punches/2B.png',
  'assets/PNG/punches/3B.png',
  'assets/PNG/punches/4B.png',
]);

final Computed<String?> cPhotoURL = computed<String?>(() {
  if (sSneakPeek.value) {
    return 'assets/PNG/punches/1.png';
  }
  return sPhotoURL.value;
});
