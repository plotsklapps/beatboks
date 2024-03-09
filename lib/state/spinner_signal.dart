import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals.dart';

final Signal<bool> sSpinner = signal<bool>(false);

final Computed<Widget> cSpinner = computed(() {
  return sSpinner.value
      ? const CircularProgressIndicator(strokeWidth: 6)
      : const FaIcon(FontAwesomeIcons.forwardStep);
});
