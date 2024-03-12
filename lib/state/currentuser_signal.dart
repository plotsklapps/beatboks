import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals/signals.dart';

// Signal for the current user (if any).
final Signal<User?> sCurrentUser =
    signal<User?>(FirebaseAuth.instance.currentUser);
