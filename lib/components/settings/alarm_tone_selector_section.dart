import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AlarmToneSelectorSection extends StatelessWidget {
  final String selectedAlarmTone;
  final List<String> alarmTones;
  final ValueChanged<String?> onChanged;

  const AlarmToneSelectorSection({super.key, required this.selectedAlarmTone, required this.alarmTones, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkBgLight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Alarm Tone',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedAlarmTone,
              dropdownColor: AppColors.darkBg,
              style: const TextStyle(color: Colors.white),
              icon: const SizedBox.shrink(),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.darkBg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                prefixIcon: const Icon(LucideIcons.music, color: Colors.white),
              ),
              items: alarmTones.map((tone) {
                return DropdownMenuItem(
                  value: tone,
                  child: Row(children: [const SizedBox(width: 8), Text(tone)]),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
