import 'package:beatboks/navigation/navigation.dart';
import 'package:beatboks/state/songlist_signal.dart';
import 'package:beatboks/theme/text_utils.dart';
import 'package:beatboks/widgets/bottomsheetheader.dart';
import 'package:beatboks/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class SummaryBottomsheet extends StatelessWidget {
  const SummaryBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Workout Summary',
            ),
            const Divider(thickness: 2),
            ListView.builder(
              shrinkWrap: true,
              itemCount: sCheckedSongList.watch(context).length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(sCheckedSongList[index].artist),
                  subtitle: Text(sCheckedSongList[index].title),
                  trailing: Text(
                    sCheckedSongList[index].duration,
                    style: TextUtils.fontL,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text(
                  'Total Duration',
                  style: TextUtils.fontXL,
                ),
                Text(
                  cTotalDuration.value,
                  style: TextUtils.fontXL,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () async {
                    if (sCheckedSongList.watch(context).isEmpty) {
                      Snacks.showErrorSnack(
                        context,
                        'Please add some songs first, we recommend 3-8 songs for a solid workout!',
                      );
                    } else {
                      // Pop the bottomsheet.
                      Navigator.pop(context);

                      // Navigate to the workout screen.
                      Navigate.toWorkoutScreen(context);
                    }
                  },
                  child: const FaIcon(FontAwesomeIcons.forwardStep),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
