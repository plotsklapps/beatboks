import 'package:beatboks/firebase_options.dart';
import 'package:beatboks/screens/start_screen.dart';
import 'package:beatboks/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
