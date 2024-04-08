import 'package:beatboks/firebase/firebase_service.dart';
import 'package:beatboks/state/displayname_signal.dart';
import 'package:beatboks/state/spinner_signal.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

final ListSignal<String> sPunchAvatarList = listSignal<String>([
  'assets/PNG/punches/1.png',
  'assets/PNG/punches/2.png',
  'assets/PNG/punches/3.png',
  'assets/PNG/punches/4.png',
  'assets/PNG/punches/5.png',
  'assets/PNG/punches/6.png',
  'assets/PNG/punches/1B.png',
  'assets/PNG/punches/2B.png',
  'assets/PNG/punches/3B.png',
  'assets/PNG/punches/4B.png',
]);

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
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sPunchAvatarList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        sPunchAvatarList.value[index],
                      ),
                    ),
                  );
                },
              ),
            ),
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
