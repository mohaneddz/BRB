import 'package:flutter/material.dart';
import 'package:brb/components/settings/labeled_slider_section.dart';
import 'package:brb/l10n/app_localizations.dart';

/// Caps the range Home's per-config "Grace" slider maps onto for
/// Distant mode (Grace 0..1 -> 0..maxDistanceMeters).
class MaxDistanceSliderSection extends StatelessWidget {
  final double maxDistanceMeters;
  final ValueChanged<double> onChanged;

  const MaxDistanceSliderSection({super.key, required this.maxDistanceMeters, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return LabeledSliderSection(
      title: AppLocalizations.of(context)!.settingsMaxDistance,
      value: maxDistanceMeters,
      min: 1,
      max: 30,
      divisions: 29,
      valueLabel: '${maxDistanceMeters.round()}m',
      onChanged: onChanged,
    );
  }
}
