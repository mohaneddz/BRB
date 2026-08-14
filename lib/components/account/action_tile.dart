import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:brb/styles/style.dart';

/// Account-page action row: icon chip + title/subtitle + chevron.
///
/// Named distinctly from settings_tiles.dart's ActionTile, which is a
/// different (Card+ListTile) implementation used on the Settings page -
/// same name, different widget, was a maintenance trap.
class ProfileActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const ProfileActionTile({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.redAccent.withAlpha(25), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: Colors.redAccent, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(color: AppColors.primaryText(context), fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle, style: TextStyle(color: AppColors.secondaryText(context), fontSize: 14)),
      trailing: Icon(LucideIcons.chevronRight, color: AppColors.secondaryText(context), size: 18),
      onTap: onTap,
    );
  }
}
