import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';

class DetectionDelaySliderSection extends StatelessWidget {
  final int detectionDelay;
  final ValueChanged<int> onChanged;

  const DetectionDelaySliderSection({super.key, required this.detectionDelay, required this.onChanged});

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
              'Detection Delay',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(
                context,
              ).copyWith(activeTrackColor: AppColors.accent, inactiveTrackColor: Colors.grey[700], thumbColor: AppColors.accent, overlayColor: AppColors.accent.withAlpha(2)),
              child: Slider(value: detectionDelay.toDouble(), min: 1, max: 10, divisions: 9, label: '${detectionDelay}s', onChanged: (value) => onChanged(value.round())),
            ),
            Text('Trigger after: ${detectionDelay}s', style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
