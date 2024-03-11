import 'package:beatboks/firebase/firebase_service.dart';
import 'package:beatboks/state/sneakpeek_signal.dart';
import 'package:signals/signals.dart';

// Signal for the displayName. We use this in the updateDisplayName method.
final Signal<String> sDisplayName = signal<String>(
  FirebaseService().displayName ?? 'New Boxer',
);

// Computed signal to watch in the UI.
final Computed<String> cDisplayName = computed(() {
  if (sSneakPeek.value) {
    return 'Sneak Peeker';
  }
  return sDisplayName.value;
});
