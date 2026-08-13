import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Account-page info row: icon chip + title/subtitle + edit pencil.
///
/// Named distinctly from settings_tiles.dart's InfoTile, which is a
/// different (Card+ListTile) implementation used on the Settings page -
/// same name, different widget, was a maintenance trap.
class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const ProfileInfoTile({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});

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
        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      trailing: const Icon(LucideIcons.edit, color: Colors.grey, size: 18),
      onTap: onTap,
    );
  }
}
