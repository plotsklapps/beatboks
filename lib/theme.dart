import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeLight = FlexThemeData.light(
  scheme: FlexScheme.outerSpace,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 7,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useTextTheme: true,
    inputDecoratorBorderType: FlexInputBorderType.underline,
    inputDecoratorUnfocusedBorderIsColored: false,
    fabUseShape: true,
    fabAlwaysCircular: true,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedLabel: false,
    navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedIcon: false,
    navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationBarIndicatorOpacity: 1,
    navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedLabel: false,
    navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedIcon: false,
    navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationRailIndicatorOpacity: 1,
    navigationRailBackgroundSchemeColor: SchemeColor.surface,
    navigationRailLabelType: NavigationRailLabelType.none,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
// To use the Playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.teko().fontFamily,
);

ThemeData themeDark = FlexThemeData.dark(
  scheme: FlexScheme.outerSpace,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    useTextTheme: true,
    inputDecoratorBorderType: FlexInputBorderType.underline,
    inputDecoratorUnfocusedBorderIsColored: false,
    fabUseShape: true,
    fabAlwaysCircular: true,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedLabel: false,
    navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedIcon: false,
    navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationBarIndicatorOpacity: 1,
    navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedLabel: false,
    navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedIcon: false,
    navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationRailIndicatorOpacity: 1,
    navigationRailBackgroundSchemeColor: SchemeColor.surface,
    navigationRailLabelType: NavigationRailLabelType.none,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  fontFamily: GoogleFonts.teko().fontFamily,
);

class TextUtils {
  static const TextStyle fontS = TextStyle(fontSize: 12);
  static const TextStyle fontM = TextStyle(fontSize: 16);
  static const TextStyle fontL = TextStyle(fontSize: 20);
  static const TextStyle fontXL = TextStyle(fontSize: 24);
  static const TextStyle fontXXL = TextStyle(fontSize: 32);
}
