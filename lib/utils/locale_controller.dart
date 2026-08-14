import 'package:flutter/material.dart';

/// App-wide locale, toggled by Settings' Language selector. A plain
/// ValueNotifier, same reasoning as theme_controller.dart's
/// themeModeNotifier - no state-management package needed for one setting.
final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

Locale localeFromLanguageName(String language) {
  return switch (language) {
    'French' => const Locale('fr'),
    _ => const Locale('en'),
  };
}
