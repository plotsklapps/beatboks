import 'package:beatboks/firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals/signals.dart';

final Signal<User?> sCurrentUser = signal<User?>(
  FirebaseService().currentUser,
);
