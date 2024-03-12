import 'package:beatboks/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

final Signal<bool> sDarkMode = signal<bool>(false);

final Computed<ThemeData> cThemeData = computed<ThemeData>(
  () {
    return sDarkMode.value ? cDarkTheme.value : cLightTheme.value;
  },
);

final Computed<Widget> cThemeModeIcon = computed(() {
  return sDarkMode.value
      ? const FaIcon(FontAwesomeIcons.solidMoon)
      : const FaIcon(FontAwesomeIcons.solidSun);
});
