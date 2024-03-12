import 'package:beatboks/state/sneakpeek_signal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals/signals.dart';

// Signal for the displayName. If user has not set their displayName yet,
// it will return 'New Boxer'.
final Signal<String?> sDisplayName = signal<String?>(
  FirebaseAuth.instance.currentUser?.displayName ?? 'New Boxer',
);

// Computed signal to watch in the UI.
final Computed<String> cDisplayName = computed(() {
  if (sSneakPeek.value) {
    return 'Sneak Peeker';
  }
  return sDisplayName.value!;
});
