import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals_flutter.dart';

final Signal<bool> sTeko = signal<bool>(true);

final Computed<String?> cFont = computed(() {
  return sTeko.value
      ? GoogleFonts.teko().fontFamily
      : GoogleFonts.manrope().fontFamily;
});

final Computed<Widget> cFontIcon = computed(() {
  return sTeko.value
      ? const FaIcon(FontAwesomeIcons.t)
      : const FaIcon(FontAwesomeIcons.bold);
});
