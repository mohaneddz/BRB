import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/utils/settings_utis.dart';
import 'package:brb/utils/theme_controller.dart';
// Components:
import 'package:brb/components/ui/content.dart';
import 'package:brb/components/ui/navigation.dart';
import 'package:brb/utils/tools/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  final settingsService = SettingsService();
  await settingsService.init();
  themeModeNotifier.value = settingsService.getDarkMode()
      ? ThemeMode.dark
      : ThemeMode.light;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: primaryTheme,
          themeMode: mode,
          home: Scaffold(
            body: Content(index: _currentIndex),
            bottomNavigationBar: MyNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTap,
            ),
          ),
        );
      },
    );
  }
}
