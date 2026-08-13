import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Lets the user pick a custom alarm sound from device files/ringtones.
/// When set, it takes priority over the built-in tone dropdown above it.
class AlarmSoundPickerSection extends StatelessWidget {
  final String? customToneName;
  final VoidCallback onPickFile;
  final VoidCallback? onClear;

  const AlarmSoundPickerSection({
    super.key,
    required this.customToneName,
    required this.onPickFile,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Alarm Sound',
              style: TextStyle(
                color: AppColors.primaryText(context),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              customToneName ?? 'Using the built-in tone selected above',
              style: TextStyle(
                color: AppColors.secondaryText(context),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onPickFile,
                    icon: const Icon(LucideIcons.music, size: 16),
                    label: const Text('Choose from Files / Ringtones'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      side: const BorderSide(color: AppColors.accent),
                    ),
                  ),
                ),
                if (customToneName != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onClear,
                    icon: Icon(LucideIcons.x, color: AppColors.secondaryText(context)),
                    tooltip: 'Use built-in tone instead',
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
