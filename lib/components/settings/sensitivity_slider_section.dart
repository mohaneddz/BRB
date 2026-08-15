import 'package:flutter/material.dart';
import 'package:brb/components/settings/labeled_slider_section.dart';
import 'package:brb/l10n/app_localizations.dart';

class SensitivitySliderSection extends StatelessWidget {
  final double sensitivity;
  final ValueChanged<double> onChanged;

  const SensitivitySliderSection({super.key, required this.sensitivity, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return LabeledSliderSection(
      title: AppLocalizations.of(context)!.settingsMotionSensitivity,
      value: sensitivity,
      min: 0.1,
      max: 1.0,
      divisions: 9,
      valueLabel: '${(sensitivity * 100).round()}%',
      onChanged: onChanged,
    );
  }
}
