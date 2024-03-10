import 'package:beatboks/firebase/firebase_service.dart';
import 'package:beatboks/state/sneakpeek_signal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals/signals.dart';

// Signal for the displayName. We use this in the updateDisplayName method.
final Signal<String> sDisplayName = signal<String>('New Boxer');

// Computed signal to watch in the UI.
final Computed<String> cDisplayName = computed<String>(() {
  // Fetch a user.
  final User? user = FirebaseService().currentUser;

  // Check if the user is a sneak peeker.
  if (sSneakPeek.value) {
    return 'Sneak Peeker';
  } else {
    // If not, he can't be anything else than a Firebase user.
    // So return the value from Firebase OR the default value from
    // the signal we created before.
    return user?.displayName ?? sDisplayName.value;
  }
});
