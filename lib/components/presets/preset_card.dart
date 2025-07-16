import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PresetCard extends StatelessWidget {
  final String title;
  final bool vibration;
  final bool lock;
  final double volume;
  final double sound;
  final String distance;
  final String delay;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PresetCard({
    super.key,
    required this.title,
    required this.vibration,
    required this.lock,
    required this.volume,
    required this.sound,
    required this.distance,
    required this.delay,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkBgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red, width: 2),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(LucideIcons.pencil, color: Colors.red),
                onPressed: onEdit,
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(LucideIcons.trash2, color: Colors.red),
                onPressed: onDelete,
                tooltip: 'Delete',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
