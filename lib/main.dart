import 'package:beatboks/firebase_options.dart';
import 'package:beatboks/navigation/navigation.dart';
import 'package:beatboks/state/thememode_signal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

// Using a GlobalKey for showing SnackBars to users.
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  // Completely boot the Flutter framework before running the application.
  WidgetsFlutterBinding.ensureInitialized();
  // Set up a connection between the app and the Firebase project.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Start the app.
  runApp(const MainEntry());
}

class MainEntry extends StatelessWidget {
  const MainEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      title: 'beatBOKS',
      // Watch the computed Signal for changes to the theme.
      theme: cThemeData.watch(context),
      initialRoute: NavString.startScreen,
      routes: routes,
    );
  }
}
