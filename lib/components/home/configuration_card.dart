// lib/components/home/configuration_card.dart
import 'package:brb/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:brb/components/ui/dropdown.dart';
import 'package:brb/components/home/settings_row.dart';
import 'package:brb/pages/presets.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ConfigurationCard extends StatefulWidget {
  const ConfigurationCard({super.key});

  @override
  State<ConfigurationCard> createState() => ConfigurationCardState();
}

class ConfigurationCardState extends State<ConfigurationCard> {
  bool vibration = true;
  bool camera = false;
  bool location = false;
  double delay = 1.0;
  double grace = 0.5;
  double sound = 0.5;
  String mode = 'Pocket';

  final List<String> modes = ['Pocket', 'Sensitive', 'Distant', 'Steps'];

  @override
  Widget build(BuildContext context) {
    // A common SliderTheme to reduce code duplication and improve visuals.
    final sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
      trackShape:
          const RoundedRectSliderTrackShape(), // Rounded ends for the track
    );

    // Common text style for slider values for consistency.
    const valueTextStyle = TextStyle(
      color: Colors.white70,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );

    return Column(
      children: [
        // Title ------------------------------------------
        const Padding(
          padding: EdgeInsets.only(top: 24.0, bottom: 16.0),
          child: Center(
            child: Text(
              'Current Configuration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Configuration Card ------------------------------------------
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkBgLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red, width: 1.5),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header with Mode dropdown and Presets button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyDropdown(
                      value: mode,
                      items: modes,
                      onChanged: (val) => setState(() => mode = val!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      // rounded corners for the button
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                      icon: const Icon(
                        LucideIcons.slidersHorizontal,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Presets(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Settings Grid ------------------------------------------
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // or .center if you prefer
                children: [
                  // Left column
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MySettingRow(
                          label: 'Delay',
                          icon: LucideIcons.timer, // Add icon
                          child: Row(
                            children: [
                              Expanded(
                                child: SliderTheme(
                                  data: sliderThemeData,
                                  child: Slider(
                                    value: delay,
                                    min: 0.5,
                                    max: 10.0,
                                    onChanged: (val) =>
                                        setState(() => delay = val),
                                    activeColor: Colors.red,
                                    inactiveColor: Colors.red.withAlpha(50),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  '${delay.toStringAsFixed(1)}s',
                                  style: valueTextStyle,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        MySettingRow(
                          label: 'Grace',
                          icon: LucideIcons.percent, // Add icon
                          child: Row(
                            children: [
                              Expanded(
                                child: SliderTheme(
                                  data: sliderThemeData,
                                  child: Slider(
                                    value: grace,
                                    onChanged: (val) =>
                                        setState(() => grace = val),
                                    activeColor: Colors.red,
                                    inactiveColor: Colors.red.withAlpha(50),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  '${(grace * 100).toInt()}%',
                                  style: valueTextStyle,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        MySettingRow(
                          label: 'Camera',
                          icon: LucideIcons.camera, // Add icon
                          inline: true,
                          child: Checkbox(
                            value: camera,
                            onChanged: (val) => setState(() => camera = val!),
                            activeColor: Colors.red,
                            checkColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.red,
                              width: 1.5,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Padded vertical separator
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: VerticalDivider(
                      color: Colors.red.withAlpha(80),
                      thickness: 1,
                    ),
                  ),

                  // Right column
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MySettingRow(
                          label: 'Sound',
                          icon: LucideIcons.volume2, // Add icon
                          child: Row(
                            children: [
                              Expanded(
                                child: SliderTheme(
                                  data: sliderThemeData,
                                  child: Slider(
                                    value: sound,
                                    onChanged: (val) =>
                                        setState(() => sound = val),
                                    activeColor: Colors.red,
                                    inactiveColor: Colors.red.withAlpha(50),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  '${(sound * 100).toInt()}%',
                                  style: valueTextStyle,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        MySettingRow(
                          label: 'Vibration',
                          icon: LucideIcons.vibrate, // Add icon
                          child: Row(
                            children: [
                              Expanded(
                                child: SliderTheme(
                                  data: sliderThemeData,
                                  child: Slider(
                                    value: vibration ? 1.0 : 0.0,
                                    divisions: 1,
                                    onChanged: (val) =>
                                        setState(() => vibration = val > 0.5),
                                    activeColor: Colors.red,
                                    inactiveColor: Colors.red.withAlpha(50),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  vibration ? 'ON' : 'OFF',
                                  style: valueTextStyle,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        MySettingRow(
                          label: 'Location',
                          icon: LucideIcons.mapPin, // Add icon
                          inline: true,
                          child: Checkbox(
                            value: location,
                            onChanged: (val) => setState(() => location = val!),
                            activeColor: Colors.red,
                            checkColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.red,
                              width: 1.5,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MySettingRow extends StatelessWidget {
  final String label;
  final Widget child;
  final double? width;
  final String align;
  final bool inline;
  final IconData? icon; // Add this line

  const MySettingRow({
    super.key,
    required this.label,
    required this.child,
    this.width,
    this.align = 'mid',
    this.inline = false,
    this.icon, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        Widget labelWidget = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Icon(icon, color: Colors.red, size: 16),
              ),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: inline ? 10 : 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        );

        if (inline) {
          // Inline layout for checkboxes
          return Row(
            children: [
              Expanded(child: labelWidget),
              child,
            ],
          );
        } else {
          // Vertical layout for sliders
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              labelWidget,
              const SizedBox(height: 1),
              SizedBox(width: availableWidth, child: child),
            ],
          );
        }
      },
    );
  }
}
