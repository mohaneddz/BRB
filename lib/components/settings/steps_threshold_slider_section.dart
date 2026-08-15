import 'package:flutter/material.dart';
import 'package:brb/components/settings/labeled_slider_section.dart';
import 'package:brb/l10n/app_localizations.dart';

/// How many steps count as "walking away" while armed in Steps mode.
class StepsThresholdSliderSection extends StatelessWidget {
  final int stepsThreshold;
  final ValueChanged<int> onChanged;

  const StepsThresholdSliderSection({super.key, required this.stepsThreshold, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return LabeledSliderSection(
      title: AppLocalizations.of(context)!.settingsStepsThreshold,
      value: stepsThreshold.toDouble(),
      min: 1,
      max: 20,
      divisions: 19,
      valueLabel: '$stepsThreshold steps',
      onChanged: (value) => onChanged(value.round()),
    );
  }
}
