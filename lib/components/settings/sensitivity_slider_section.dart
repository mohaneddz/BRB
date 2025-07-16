import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';

class SensitivitySliderSection extends StatelessWidget {
  final double sensitivity;
  final ValueChanged<double> onChanged;

  const SensitivitySliderSection({super.key, required this.sensitivity, required this.onChanged});

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
              'Motion Sensitivity',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(
                context,
              ).copyWith(activeTrackColor: AppColors.accent, inactiveTrackColor: Colors.grey[700], thumbColor: AppColors.accent, overlayColor: AppColors.accent.withAlpha(2)),
              child: Slider(value: sensitivity, min: 0.1, max: 1.0, divisions: 9, label: '${(sensitivity * 100).round()}%', onChanged: onChanged),
            ),
            Text('Current: ${(sensitivity * 100).round()}%', style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
