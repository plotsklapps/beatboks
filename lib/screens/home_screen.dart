import 'package:beatboks/modals/settings_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: <Widget>[
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(child: FaIcon(FontAwesomeIcons.userLarge)),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(child: FaIcon(FontAwesomeIcons.chartColumn)),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(child: FaIcon(FontAwesomeIcons.calendarCheck)),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return songSelectList[index];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the StartScreen.
          Navigator.pop(context);
        },
        child: const FaIcon(FontAwesomeIcons.forwardStep),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const SettingsBottomSheet();
                  },
                );
              },
              icon: const FaIcon(FontAwesomeIcons.gear),
            ),
          ],
        ),
      ),
    );
  }
}

List<SongSelectCard> songSelectList = <SongSelectCard>[
  SongSelectCard(
    title: 'Eminem',
    subTitle: 'Till I Collapse',
    onTap: () {},
  ),
  SongSelectCard(
    title: 'Kanye West',
    subTitle: 'POWER',
    onTap: () {},
  ),
  SongSelectCard(
    title: 'Otherwise',
    subTitle: 'Soldiers',
    onTap: () {},
  ),
  SongSelectCard(
    title: 'Eminem',
    subTitle: 'Till I Collapse',
    onTap: () {},
  ),
  SongSelectCard(
    title: 'Kanye West',
    subTitle: 'POWER',
    onTap: () {},
  ),
  SongSelectCard(
    title: 'Otherwise',
    subTitle: 'Soldiers',
    onTap: () {},
  ),
  SongSelectCard(
    title: 'Eminem',
    subTitle: 'Till I Collapse',
    onTap: () {},
  ),
  SongSelectCard(
    title: 'Kanye West',
    subTitle: 'POWER',
    onTap: () {},
  ),
  SongSelectCard(
    title: 'Otherwise',
    subTitle: 'Soldiers',
    onTap: () {},
  ),
];

class SongSelectCard extends StatefulWidget {
  const SongSelectCard({
    required this.title,
    required this.subTitle,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subTitle;
  final VoidCallback onTap;

  @override
  State<SongSelectCard> createState() => _SongSelectCardState();
}

class _SongSelectCardState extends State<SongSelectCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: widget.onTap,
              leading: const FaIcon(FontAwesomeIcons.circlePlay),
              title: Text(widget.title),
              subtitle: Text(widget.subTitle),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: isChecked
                    ? const FaIcon(FontAwesomeIcons.circleCheck)
                    : const FaIcon(FontAwesomeIcons.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
