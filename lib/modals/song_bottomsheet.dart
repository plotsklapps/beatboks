import 'package:beatboks/state/songlist_signal.dart';
import 'package:beatboks/theme/text_utils.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SongBottomSheet extends StatelessWidget {
  const SongBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Song Details',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Artist'),
                Text('Eminem (feat. Nate Dogg)', style: TextUtils.fontL),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Songtitle'),
                Text('Till I Collapse', style: TextUtils.fontL),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Album'),
                Text('The Eminem Show', style: TextUtils.fontL),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Year'),
                Text('2002', style: TextUtils.fontL),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Genre'),
                Text('Hip Hop', style: TextUtils.fontL),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Duration'),
                Text('5:25', style: TextUtils.fontL),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    isEminemChecked.value = !isEminemChecked.value;

                    if (isEminemChecked.value == true) {
                      sCheckedSongs.value++;
                    } else {
                      sCheckedSongs.value--;
                    }

                    // Pop the bottomsheet.
                    Navigator.pop(context);

                    // Show a SnackBar.
                    Snacks.showSuccessSnack(
                      context,
                      'This song is added to your workout playlist',
                    );
                  },
                  child: const FaIcon(FontAwesomeIcons.plus),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
