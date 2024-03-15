import 'package:beatboks/state/displayname_signal.dart';
import 'package:beatboks/state/email_signal.dart';
import 'package:beatboks/state/lastvisit_signal.dart';
import 'package:beatboks/state/photoURL_signal.dart';
import 'package:beatboks/state/sneakpeek_signal.dart';
import 'package:beatboks/state/spinner_signal.dart';
import 'package:beatboks/state/themecolor_signal.dart';
import 'package:beatboks/state/themefont_signal.dart';
import 'package:beatboks/state/thememode_signal.dart';
import 'package:beatboks/state/uid_signal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class FirebaseService {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SIGN UP

  Future<void> signUp({
    required String email,
    required String password,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      // Create new user.
      await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = _firebase.currentUser;

      if (user != null) {
        // Send verification email.
        await user.sendEmailVerification();

        // Log the success.
        Logger().i('User created, verification email sent.');

        // Trigger the onSuccess callback.
        onSuccess();
      } else {
        // Log the error.
        Logger().e('Unexpected error: User not found.');

        // Trigger the onError callback.
        onError('Unexpected error: User not found.');
      }
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
  }

  // SIGN IN

  Future<void> signIn({
    required String email,
    required String password,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      // Sign in the user.
      await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = _firebase.currentUser;

      if (user != null) {
        if (user.emailVerified) {
          // Log the success.
          Logger().i('User signed in via Firebase.');

          // Trigger the onSuccess callback.
          onSuccess();
        } else {
          // Log the error.
          Logger().e('User exists, but is not verified.');

          // Trigger the onError callback.
          onError('User exists, but is not verified.');
        }
      } else {
        // Log the error.
        Logger().e('Unexpected error: No user found.');

        // Trigger the onError callback.
        onError('Unexpected error: No user found.');
      }
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
  }

  // SIGN IN ANONYMOUSLY

  Future<void> signInAnonymously({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      // Set sneak peek to true.
      sSneakPeek.value = true;

      // Log the success.
      Logger().i('User signed in as sneak peeker.');

      // Trigger the onSuccess callback.
      onSuccess();
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
  }

  // SIGN OUT

  Future<void> signOut({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      if (!sSneakPeek.value) {
        // Sign out from Firebase.
        await _firebase.signOut();

        // Set all signals to default.
        sUID.value = '';
        sEmail.value = 'JohnDoe@email.com';
        sDisplayName.value = 'New Boxer';
        sPhotoURL.value = '';
        sDarkMode.value = false;
        sTeko.value = true;
        sOuterSpace.value = true;
        sLastVisit.value = DateFormat('dd-MM-yyyy').format(DateTime.now());
        sSpinner.value = false;

        // Log the success.
        Logger().i('User signed out.');

        // Trigger the onSuccess callback.
        onSuccess();
      } else {
        // Set sneak peek to false.
        sSneakPeek.value = false;

        // Log the success.
        Logger().i('User signed out.');

        // Trigger the onSuccess callback.
        onSuccess();
      }
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
  }

  // CHECK EMAIL VERIFICATION

  Future<void> checkEmailVerified({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      final User? user = _firebase.currentUser;

      if (user != null) {
        // Force reload the user.
        await user.reload();

        // Fetch the updated user.
        final User? updatedUser = _firebase.currentUser;

        if (updatedUser != null && updatedUser.emailVerified) {
          // Log the success.
          Logger().i('User has verified their email address.');

          // Trigger the onSuccess callback.
          onSuccess();
        } else {
          // Log the error.
          Logger().e('User is not email verified.');

          // Trigger the onError callback.
          onError(
              'Please verify your email address. If you already have, please '
              'allow a few moments for the verification status to update.');
        }
      } else {
        // Log the error.
        Logger().e('Unexpected error: No user found.');

        // Trigger the onError callback.
        onError('Unexpected error: No user found.');
      }
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
  }

  // UPDATE EMAIL

  Future<void> updateEmail({
    required String email,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      final User? user = _firebase.currentUser;

      if (user != null) {
        // Send verification mail to update.
        await user.verifyBeforeUpdateEmail(email);

        // Log the success.
        Logger().i('Verification mail sent.');

        // Trigger the onSuccess callback.
        onSuccess();
      } else {
        // Log the error.
        Logger().e('Unexpected error: No user found.');

        // Trigger the onError callback.
        onError('Unexpected error: No user found.');
      }
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
  }

  // UPDATE PASSWORD

  Future<void> updatePassword({
    required String email,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      // Send password reset email.
      await _firebase.sendPasswordResetEmail(email: email);

      // Log the success.
      Logger().i('Password reset email sent.');

      // Trigger the onSuccess callback.
      onSuccess();
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
  }

  // UPDATE DISPLAYNAME

  Future<void> updateDisplayName({
    required String displayName,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      final User? user = _firebase.currentUser;

      if (user != null) {
        // Update displayName to Firebase.
        await user.updateDisplayName(displayName);

        // Update displayName to Firestore.
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update(<String, String>{
          'displayName': displayName,
        });

        // Log the success.
        Logger().i('Display name updated.');

        // Trigger the onSuccess callback.
        onSuccess();
      } else {
        // Log the error.
        Logger().e('Unexpected error: No user found.');

        // Trigger the onError callback.
        onError('Unexpected error: No user found.');
      }
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Trigger the onError callback.
      onError(error.toString());
    }
  }
}
