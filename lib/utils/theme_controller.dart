import 'package:flutter/material.dart';

/// App-wide theme mode, toggled by Settings' Dark Mode switch. A plain
/// ValueNotifier is enough here - the app has no other cross-screen shared
/// state, so pulling in a state-management package for one switch would be
/// overkill.
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
  ThemeMode.dark,
);
