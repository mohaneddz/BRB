import 'package:flutter/material.dart';
import 'package:brb/components/settings/labeled_slider_section.dart';
import 'package:brb/l10n/app_localizations.dart';

/// Same knob as Home's per-config "Delay" slider - both read/write the
/// same persisted value, this is just a second, more discoverable place
/// to tune it.
class DetectionDelaySliderSection extends StatelessWidget {
  final double detectionDelay;
  final ValueChanged<double> onChanged;

  const DetectionDelaySliderSection({super.key, required this.detectionDelay, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return LabeledSliderSection(
      title: AppLocalizations.of(context)!.settingsDetectionDelay,
      value: detectionDelay,
      min: 0.5,
      max: 10.0,
      valueLabel: 'Trigger after: ${detectionDelay.toStringAsFixed(1)}s',
      onChanged: onChanged,
    );
  }
}
