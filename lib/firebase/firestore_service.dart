import 'package:beatboks/state/creationdate_signal.dart';
import 'package:beatboks/state/displayname_signal.dart';
import 'package:beatboks/state/email_signal.dart';
import 'package:beatboks/state/lastvisit_signal.dart';
import 'package:beatboks/state/photoURL_signal.dart';
import 'package:beatboks/state/theme_signal.dart';
import 'package:beatboks/state/uid_signal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class FirestoreService {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new user document in Firestore under the 'users' collection and
  // the user's uid as the document id.
  Future<void> createUserDoc() async {
    final User? user = _firebase.currentUser;

    if (user != null) {
      try {
        // Create the new doc.
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(<String, dynamic>{
          'uid': user.uid,
          'email': user.email ?? '',
          'emailVerified': user.emailVerified,
          'displayName': user.displayName ?? '',
          'photoURL': user.photoURL ?? '',
          'createdAt': DateTime.now(),
          'lastVisit': DateTime.now(),
          'darkMode': sDarkMode.value,
        });

        // Log the success.
        Logger().i('User document created.');
      } catch (error) {
        // Log the error.
        Logger().e(error);
      }
    } else {
      // Log the error.
      Logger().e('Unexpected error: User not found.');
    }
  }

  // Fetch the user document from Firestore and store the values to their
  // respective signals.
  Future<void> fetchUserDoc() async {
    final User? user = _firebase.currentUser;

    if (user != null) {
      try {
        // Fetch the doc.
        final DocumentSnapshot<Map<String, dynamic>> doc =
            await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists) {
          // Fetch the data from the doc.
          final Map<String, dynamic>? data = doc.data();

          if (data != null) {
            // Set the signals.
            sUID.value = data['uid'] as String;
            sEmail.value = data['email'] as String;
            sEmailVerified.value = data['emailVerified'] as bool;
            sDisplayName.value = data['displayName'] as String;
            sPhotoURL.value = data['photoURL'] as String;
            sDarkMode.value = data['darkMode'] as bool;

            final Timestamp creationDate = data['createdAt'] as Timestamp;
            sCreationDate.value = creationDate.toDate();

            final Timestamp lastVisit = data['lastVisit'] as Timestamp;
            sLastVisit.value = lastVisit.toDate();

            // Log the success.
            Logger().i('User document fetched.');
          } else {
            // Log the error.
            Logger().e('Unexpected error: User document data not found.');
          }
        } else {
          // Log the error.
          Logger().e('Unexpected error: User document not found.');
        }
      } catch (error) {
        // Log the error.
        Logger().e(error);
      }
    } else {
      // Log the error.
      Logger().e('Unexpected error: User not found.');
    }
  }
}
