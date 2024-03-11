import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class FirestoreService {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new user document in Firestore under the 'users' collection and
  // the user's uid as the document id.
  Future<void> createUserDoc({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    final User? user = _firebase.currentUser;

    if (user != null) {
      try {
        // Create the new doc.
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(<String, dynamic>{
          'uid': user.uid,
          'email': user.email,
          'emailVerified': user.emailVerified,
          'displayName': user.displayName,
          'photoURL': user.photoURL,
          'lastSeen': DateTime.now(),
        });

        // Log the success.
        Logger().i('User document created.');

        // Trigger the onSuccess callback.
        onSuccess();
      } catch (error) {
        // Log the error.
        Logger().e(error);

        // Trigger the onError callback.
        onError(error.toString());
      }
    } else {
      // Log the error.
      Logger().e('Unexpected error: User not found.');

      // Trigger the onError callback.
      onError('Unexpected error: User not found.');
    }
  }

  // Fetch the user document from Firestore and store the values to their
// respective signals.
  Future<void> fetchUserDoc({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    final User? user = _firebase.currentUser;

    if (user != null) {
      try {
        // Fetch the doc.
        final DocumentSnapshot<Map<String, dynamic>> doc =
            await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists) {
          // Fetch the data from the doc.
          final Map<String, dynamic> data = doc.data()!;

          // Set the signals.

          // Log the success.
          Logger().i('User document fetched.');
        }

        Logger().i('User document fetched.');
      } catch (error) {
        Logger().e(error);
      }
    } else {}
  }
}
