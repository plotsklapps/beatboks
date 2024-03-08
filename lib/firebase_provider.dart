import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// ignore: always_specify_types
final firebaseProvider =
    NotifierProvider<FirebaseNotifier, FirebaseAuth>(FirebaseNotifier.new);

class FirebaseNotifier extends Notifier<FirebaseAuth> {
  @override
  FirebaseAuth build() {
    return FirebaseAuth.instance;
  }

  User? get currentUser {
    return state.currentUser;
  }

  String? get email {
    return state.currentUser!.email;
  }

  bool? get emailVerified {
    return state.currentUser!.emailVerified;
  }

  String? get displayName {
    return state.currentUser!.displayName;
  }

  String? get photoURL {
    return state.currentUser!.photoURL;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      // Create new user.
      await state.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send verification email.
      await state.currentUser!.sendEmailVerification();

      // Log the success.
      Logger().i('User created, verification email sent');

      // Trigger the onSuccess callback.
      onSuccess();
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
  }

  void signIn(String email, String password) {
    state.signInWithEmailAndPassword(email: email, password: password);
  }

  void signOut() {
    state.signOut();
  }

  void sendPasswordResetEmail(String email) {
    state.sendPasswordResetEmail(email: email);
  }

  void updateEmail(String email) {
    state.currentUser!.verifyBeforeUpdateEmail(email);
  }

  void updatePassword(String email) {
    state.sendPasswordResetEmail(email: email);
  }
}
