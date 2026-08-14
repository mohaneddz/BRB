import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/utils/settings_utis.dart';
import 'package:brb/utils/theme_controller.dart';
import 'package:brb/utils/locale_controller.dart';
import 'package:brb/l10n/app_localizations.dart';
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
  localeNotifier.value = localeFromLanguageName(settingsService.getLanguage());
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
        return ValueListenableBuilder<Locale>(
          valueListenable: localeNotifier,
          builder: (context, locale, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: primaryTheme,
              themeMode: mode,
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
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
      },
    );
  }
}
