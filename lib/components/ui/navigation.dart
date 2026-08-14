import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:brb/l10n/app_localizations.dart';

class MyNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MyNavigationBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(icon: const Icon(LucideIcons.home), label: l10n.navHome),
        BottomNavigationBarItem(icon: const Icon(LucideIcons.history), label: l10n.navHistory),
        BottomNavigationBarItem(icon: const Icon(LucideIcons.user), label: l10n.navAccount),
        BottomNavigationBarItem(icon: const Icon(LucideIcons.cog), label: l10n.navSettings),
      ],
    );
  }
}
