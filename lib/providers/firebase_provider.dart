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

  Future<void> signIn({
    required String email,
    required String password,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      // Sign in the user.
      await state.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (state.currentUser != null) {
        if (state.currentUser!.emailVerified) {
          // Log the success.
          Logger().i('User signed in');

          // Trigger the onSuccess callback.
          onSuccess();
        } else {
          // Log the error.
          Logger().e('User exists, but is not verified');

          // Trigger the onError callback.
          onError('User exists, but is not verified.');
        }
      }
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
  }

  void signOut() {
    state.signOut();
  }

  Future<void> checkEmailVerified({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      // Force reload the user.
      await state.currentUser!.reload();

      if (state.currentUser!.emailVerified) {
        // Log the success.
        Logger().i('User verified');

        // Trigger the onSuccess callback.
        onSuccess();
      } else {
        // Log the error.
        Logger().e('User not verified');

        // Trigger the onError callback.
        onError('Our backend has not responded yet. Take a deep breath and '
            'try again.');
      }
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
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
