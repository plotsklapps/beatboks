import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

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
