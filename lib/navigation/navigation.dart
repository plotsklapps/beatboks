import 'package:beatboks/screens/home_screen.dart';
import 'package:beatboks/screens/start_screen.dart';
import 'package:flutter/material.dart';

// Class dedicated to navigational Strings to avoid typo's.
class NavString {
  static String startScreen = '/startScreen';
  static String homeScreen = '/home';
}

// Defining routes with key-value pairs to use in the Navigate class.
final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  NavString.startScreen: (BuildContext context) {
    return const StartScreen();
  },
  NavString.homeScreen: (BuildContext context) {
    return const HomeScreen();
  },
};

// Creating a more convenient way of navigating inside the app.
class Navigate {
  static void toStartScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, NavString.startScreen);
  }

  static void toHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, NavString.homeScreen);
  }
}
