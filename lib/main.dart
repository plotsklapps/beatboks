import 'package:beatboks/firebase_options.dart';
import 'package:beatboks/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<void> main() async {
  // Completely boot the Flutter framework before running the application.
  WidgetsFlutterBinding.ensureInitialized();
  // Set up a connection between the app and the Firebase project.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Start the app, wrapped in Riverpod's ProviderScope.
  runApp(const ProviderScope(child: MainEntry()));
}

class MainEntry extends StatelessWidget {
  const MainEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeLight,
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
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
              return SizedBox(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    MediaQuery.viewInsetsOf(context).bottom + 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Choose a sign in method',
                          style: TextUtils.fontL,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const FaIcon(FontAwesomeIcons.xmark),
                        ),
                      ),
                      const Divider(thickness: 2),
                      const SizedBox(height: 16),
                      ListTile(
                        onTap: () {},
                        leading: const FaIcon(FontAwesomeIcons.userPlus),
                        title: const Text(
                          'Create an account',
                          style: TextUtils.fontL,
                        ),
                        subtitle: const Text('Get a personalized experience'
                            ' and save your statistics (recommended)'),
                      ).animate().fade().moveX(delay: 200.ms, begin: -32),
                      ListTile(
                        onTap: () {},
                        leading: const FaIcon(FontAwesomeIcons.userCheck),
                        title: const Text(
                          'Use an existing account',
                          style: TextUtils.fontL,
                        ),
                        subtitle: const Text("You've already used beatBOKS "
                            'before and want to sign in'),
                      )
                          .animate()
                          .fade(delay: 200.ms)
                          .moveX(delay: 400.ms, begin: -32),
                      ListTile(
                        onTap: () {},
                        leading: const FaIcon(FontAwesomeIcons.userSecret),
                        title: const Text(
                          'Sneak peek',
                          style: TextUtils.fontL,
                        ),
                        subtitle: const Text('Try out beatBOKS anonymously '
                            'without storing any data'),
                      )
                          .animate()
                          .fade(delay: 400.ms)
                          .moveX(delay: 600.ms, begin: -32),
                    ],
                  ),
                ),
              );
            },
          );
        },
        tooltip: 'Continue',
        child: const FaIcon(FontAwesomeIcons.forwardStep),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
      ),
    );
  }
}
