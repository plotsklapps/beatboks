import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals/signals.dart';

// Signal for the photoURL. If user has not set their photoURL yet,
// it will return an empty String.
final Signal<String?> sPhotoURL =
    signal<String?>(FirebaseAuth.instance.currentUser?.photoURL ?? '');
