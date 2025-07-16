import 'package:flutter/material.dart';

import 'package:brb/pages/home.dart';
import 'package:brb/pages/history.dart';
import 'package:brb/pages/account.dart';
import 'package:brb/pages/settings.dart';

class Content extends StatelessWidget {
  final int index;
  const Content({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const Home(title: 'Home');
      case 1:
        return const History();
      case 2:
        return const Account();
      case 3:
        return const Settings();
      default:
        return const Home(title: 'Home');
    }
  }
}
