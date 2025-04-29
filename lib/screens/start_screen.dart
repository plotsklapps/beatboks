import 'package:beatboks/firebase/firestore_service.dart';
import 'package:beatboks/modals/startscreen_bottomsheet.dart';
import 'package:beatboks/navigation/navigation.dart';
import 'package:beatboks/state/spinner_signal.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirestoreService _firestore = FirestoreService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthentication();
    });
  }

  Future<void> _checkAuthentication() async {
    // Start the spinner.
    sSpinner.value = true;

    try {
      final User? user = _firebase.currentUser;

      if (user != null) {
        if (user.emailVerified) {
          // Fetch user doc.
          await _firestore.fetchUserDoc();

          if (mounted) {
            // Navigate to the HomeScreen.
            Navigate.toHomeScreen(context);

            // Show a SnackBar.
            Snacks.showSuccessSnack(
              context,
              'Welcome back, ${user.displayName}! Have a great workout.',
            );
          }
        } else {
          // Log the error.
          Logger().e('User is signed in but NOT verified.');

          // Show a SnackBar.
          Snacks.showErrorSnack(
            context,
            'Your account was created, but your email has not been '
            'verified yet. Please verify your email address to continue.',
          );

          return;
        }
      }
    } on Exception catch (error) {
      // Log the error.
      Logger().e(error);

      if (mounted) {
        // Show a SnackBar.
        Snacks.showErrorSnack(context, error.toString());
      }
    } finally {
      // Cancel the spinner.
      sSpinner.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/GIF/littleBoxer.gif'),
                const Text(
                  'beat',
                  style: TextStyle(fontSize: 42),
                ).animate().fade(delay: 400.ms).scale(delay: 600.ms),
                const Text(
                  'BOKS',
                  style: TextStyle(
                    fontSize: 54,
                  ),
                ).animate().fade(delay: 800.ms).scale(delay: 1000.ms),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<Widget>(
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const StartScreenBottomSheet();
            },
          );
        },
        tooltip: 'Continue',
        child: cSpinner.watch(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
      ),
    );
  }
}
