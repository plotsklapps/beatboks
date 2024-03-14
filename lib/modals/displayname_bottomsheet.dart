import 'package:beatboks/firebase/firebase_service.dart';
import 'package:beatboks/state/displayname_signal.dart';
import 'package:beatboks/state/spinner_signal.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class DisplayNameBottomsheet extends StatefulWidget {
  const DisplayNameBottomsheet({super.key});

  @override
  State<DisplayNameBottomsheet> createState() {
    return _DisplayNameBottomsheetState();
  }
}

class _DisplayNameBottomsheetState extends State<DisplayNameBottomsheet> {
  final FirebaseService _firebase = FirebaseService();
  late TextEditingController _displayNameController;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        // Allow the bottomsheet to be pushed up by the keyboard.
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          MediaQuery.viewInsetsOf(context).bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Change your username',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            TextField(
              controller: _displayNameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                icon: FaIcon(FontAwesomeIcons.userPen),
                labelText: 'Name',
              ),
            ).animate().fade().moveX(delay: 200.ms),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Cancel the spinner.
                    sSpinner.value = false;

                    // Pop the bottomsheet.
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // Start the spinner.
                    sSpinner.value = true;

                    // Set the signal.
                    sDisplayName.value = _displayNameController.text.trim();

                    // Update the displayName in Firebase and Firestore.
                    _firebase.updateDisplayName(
                      displayName: sDisplayName.value!,
                      onError: (String error) {
                        // Cancel the spinner.
                        sSpinner.value = false;

                        // Show a SnackBar.
                        Snacks.showErrorSnack(context, error);
                      },
                      onSuccess: () {
                        // Cancel the spinner.
                        sSpinner.value = false;

                        // Pop the bottomsheet.
                        Navigator.pop(context);

                        // Show a SnackBar.
                        Snacks.showSuccessSnack(
                          context,
                          'Username changed! Hello, '
                          '${sDisplayName.value}!',
                        );
                      },
                    );
                  },
                  // Show Spinner or Icon.
                  child: cSpinner.watch(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
