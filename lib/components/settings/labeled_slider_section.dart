import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';

/// Shared Card+Slider layout used by every "tune a detection number"
/// row in Settings (sensitivity, delay, steps threshold, max distance).
class LabeledSliderSection extends StatelessWidget {
  final String title;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double> onChanged;

  const LabeledSliderSection({
    super.key,
    required this.title,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkBgLight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.accent,
                inactiveTrackColor: Colors.grey[700],
                thumbColor: AppColors.accent,
                overlayColor: AppColors.accent.withAlpha(2),
              ),
              child: Slider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                label: valueLabel,
                onChanged: onChanged,
              ),
            ),
            Text(
              valueLabel,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
