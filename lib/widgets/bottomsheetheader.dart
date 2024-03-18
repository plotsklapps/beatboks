import 'package:beatboks/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Header used inside all bottomsheets for a consistent look.
class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextUtils.fontXL,
      ),
      trailing: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const FaIcon(FontAwesomeIcons.xmark),
      ),
    );
  }
}
