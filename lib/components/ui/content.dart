import 'package:flutter/material.dart';

import 'package:brb/pages/home.dart';
import 'package:brb/pages/history.dart';
import 'package:brb/pages/account.dart';
import 'package:brb/pages/settings.dart';
import 'package:brb/l10n/app_localizations.dart';

class Content extends StatelessWidget {
  final int index;
  const Content({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final homeTitle = AppLocalizations.of(context)!.navHome;
    switch (index) {
      case 0:
        return Home(title: homeTitle);
      case 1:
        return const History();
      case 2:
        return const Account();
      case 3:
        return const Settings();
      default:
        return Home(title: homeTitle);
    }
  }
}
