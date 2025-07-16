import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;
  final String? subtitle;
  final bool enabled;

  const SwitchTile({super.key, required this.title, required this.value, required this.onChanged, required this.icon, this.subtitle, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkBgLight,
      child: ListTile(
        leading: Icon(icon, color: enabled ? AppColors.accent : Colors.grey),
        title: Text(
          title,
          style: TextStyle(color: enabled ? Colors.white : Colors.grey, fontWeight: FontWeight.w500),
        ),
        subtitle: subtitle != null ? Text(subtitle!, style: TextStyle(color: enabled ? Colors.grey : Colors.grey.withAlpha(150), fontSize: 12)) : null,
        trailing: Switch(value: value, onChanged: enabled ? onChanged : null, activeColor: AppColors.accent),
        enabled: enabled,
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  const ActionTile({super.key, required this.title, required this.subtitle, required this.icon, required this.onTap, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkBgLight,
      child: ListTile(
        leading: Icon(icon, color: enabled ? AppColors.accent : Colors.grey),
        title: Text(
          title,
          style: TextStyle(color: enabled ? Colors.white : Colors.grey, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: enabled ? Colors.grey : Colors.grey.withAlpha(150), fontSize: 12)),
        trailing: const Icon(LucideIcons.chevronRight, color: Colors.grey, size: 16),
        onTap: enabled ? onTap : null,
        enabled: enabled,
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkBgLight,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        trailing: Text(value, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
