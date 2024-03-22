import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.onPressed,
    super.key,
  });

  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Signal<bool> isChecked;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: FaIcon(leadingIcon),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: IconButton(
            onPressed: onPressed,
            icon: FaIcon(
              isChecked.value
                  ? FontAwesomeIcons.circleCheck
                  : FontAwesomeIcons.circle,
            ),
          ),
        ),
      ),
    );
  }
}
