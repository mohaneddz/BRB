// lib/components/home/configuration_card.dart
import 'package:brb/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:brb/components/ui/dropdown.dart';
import 'package:brb/components/home/settings_row.dart';
import 'package:brb/models/config_values.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ConfigurationCard extends StatefulWidget {
  final ConfigValues initialValues;
  final ValueChanged<ConfigValues> onChanged;
  final VoidCallback onOpenPresets;
  final bool locked;

  const ConfigurationCard({
    super.key,
    required this.initialValues,
    required this.onChanged,
    required this.onOpenPresets,
    this.locked = false,
  });

  @override
  State<ConfigurationCard> createState() => ConfigurationCardState();
}

class ConfigurationCardState extends State<ConfigurationCard> {
  late bool vibration;
  late bool camera;
  late bool location;
  late double delay;
  late double grace;
  late double sound;
  late String mode;

  final List<String> modes = ['Pocket', 'Sensitive', 'Distant', 'Steps'];

  @override
  void initState() {
    super.initState();
    _applyFrom(widget.initialValues);
  }

  void _applyFrom(ConfigValues values) {
    mode = values.mode;
    delay = values.delay;
    grace = values.grace;
    camera = values.camera;
    location = values.location;
    sound = values.sound;
    vibration = values.vibration;
  }

  /// Called by the Home screen after a Preset was applied elsewhere, so the
  /// card reflects the new values without a full rebuild.
  void applyValues(ConfigValues values) {
    setState(() => _applyFrom(values));
  }

  void _emitChange() {
    widget.onChanged(
      ConfigValues(
        mode: mode,
        delay: delay,
        grace: grace,
        camera: camera,
        location: location,
        sound: sound,
        vibration: vibration,
      ),
    );
  }

  void _update(VoidCallback mutate) {
    setState(mutate);
    _emitChange();
  }

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
                      onChanged: (val) {
                        if (widget.locked || val == null) return;
                        _update(() => mode = val);
                      },
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
                      onPressed: widget.onOpenPresets,
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
                                    onChanged: widget.locked
                                        ? null
                                        : (val) =>
                                              _update(() => delay = val),
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
                                    onChanged: widget.locked
                                        ? null
                                        : (val) =>
                                              _update(() => grace = val),
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
                            onChanged: widget.locked
                                ? null
                                : (val) => _update(() => camera = val!),
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
                                    onChanged: widget.locked
                                        ? null
                                        : (val) =>
                                              _update(() => sound = val),
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
                                    onChanged: widget.locked
                                        ? null
                                        : (val) => _update(
                                            () => vibration = val > 0.5,
                                          ),
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
                            onChanged: widget.locked
                                ? null
                                : (val) => _update(() => location = val!),
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
