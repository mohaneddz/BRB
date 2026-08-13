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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alarm Tone',
              style: TextStyle(color: AppColors.primaryText(context), fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedAlarmTone,
              dropdownColor: AppColors.background(context),
              style: TextStyle(color: AppColors.primaryText(context)),
              icon: const SizedBox.shrink(),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.background(context),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                prefixIcon: Icon(LucideIcons.music, color: AppColors.primaryText(context)),
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
