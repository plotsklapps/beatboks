import 'package:beatboks/theme/theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals.dart';

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

final Signal<bool> sTeko = signal<bool>(true);

final Computed<String?> cFont = computed(() {
  return sTeko.value
      ? GoogleFonts.teko().fontFamily
      : GoogleFonts.questrial().fontFamily;
});

final Computed<Widget> cFontIcon = computed(() {
  return sTeko.value
      ? const FaIcon(FontAwesomeIcons.t)
      : const FaIcon(FontAwesomeIcons.bold);
});

final Signal<bool> sOuterSpace = signal<bool>(true);

final Computed<FlexScheme> cColor = computed<FlexScheme>(
  () {
    return sOuterSpace.value ? FlexScheme.outerSpace : FlexScheme.money;
  },
);

final Computed<Widget> cColorIcon = computed(() {
  return sOuterSpace.value
      ? const FaIcon(FontAwesomeIcons.spaceAwesome)
      : const FaIcon(FontAwesomeIcons.moneyBillWave);
});
