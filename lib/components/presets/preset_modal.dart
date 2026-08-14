import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/components/home/settings_row.dart';
import 'package:brb/models/challenge_type.dart';
import 'package:brb/utils/tools/challenge_service.dart';
import 'package:lucide_icons/lucide_icons.dart';

Future<void> showPresetModal({
  required BuildContext context,
  String? initialTitle,
  bool initialVibration = true,
  String initialChallengeType = 'none',
  bool initialCamera = false,
  bool initialLocation = false,
  double initialVolume = 0.5,
  double initialSound = 0.5,
  String initialDistance = '1m',
  String initialDelay = '1s',
  String initialMode = 'Pocket',
  required void Function({
    required String title,
    required bool vibration,
    required String challengeType,
    required bool camera,
    required bool location,
    required double volume,
    required double sound,
    required String distance,
    required String delay,
    required String mode,
  })
  onSave,
}) async {
  final titleController = TextEditingController(text: initialTitle ?? '');
  bool vibration = initialVibration;
  ChallengeType challengeType = ChallengeType.fromName(initialChallengeType);
  bool camera = initialCamera;
  bool location = initialLocation;
  double volume = initialVolume;
  double sound = initialSound;
  String distance = initialDistance;
  String delay = initialDelay;
  String mode = initialMode;

  final prefs = await SharedPreferences.getInstance();
  final challengeService = ChallengeService();
  final pinConfigured = challengeService.isPinEnabled(prefs) &&
      (challengeService.getPin(prefs)?.isNotEmpty ?? false);
  final digitCodeConfigured = challengeService.isDigitCodeEnabled(prefs) &&
      (challengeService.getDigitCode(prefs)?.isNotEmpty ?? false);
  if (!context.mounted) return;

  final modes = ['Pocket', 'Sensitive', 'Distant', 'Steps'];

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface(context),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Container(
        color: AppColors.surface(context),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              // Common slider theme and value text style for consistency
              final sliderThemeData = SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 14.0,
                ),
                trackShape: const RoundedRectSliderTrackShape(),
              );
              final valueTextStyle = TextStyle(
                color: AppColors.secondaryText(context),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              );

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      initialTitle == null ? 'Add Preset' : 'Edit Preset',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.primaryText(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: AppColors.secondaryText(context)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: TextStyle(color: AppColors.primaryText(context)),
                    ),
                    const SizedBox(height: 24),

                    // Mode dropdown (spanning full width)
                    MySettingRow(
                      label: 'Mode',
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.background(context),
                          border: Border.all(color: Colors.red, width: 1.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: mode,
                                  items: modes
                                      .map(
                                        (m) => DropdownMenuItem(
                                          value: m,
                                          child: Text(
                                            m,
                                            style: TextStyle(
                                              color: AppColors.primaryText(context),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => mode = val!),
                                  dropdownColor: AppColors.dropdownSurface(context),
                                  icon:
                                      const SizedBox.shrink(), // hide default icon
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              LucideIcons.settings,
                              color: Colors.red,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Settings Grid (two columns)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              MySettingRow(
                                label: 'Delay',
                                icon: LucideIcons.timer,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SliderTheme(
                                        data: sliderThemeData,
                                        child: Slider(
                                          value:
                                              double.tryParse(
                                                delay.replaceAll('s', ''),
                                              ) ??
                                              1.0,
                                          min: 0.5,
                                          max: 10.0,
                                          onChanged: (val) => setState(
                                            () => delay =
                                                '${val.toStringAsFixed(1)}s',
                                          ),
                                          activeColor: Colors.red,
                                          inactiveColor: Colors.red.withAlpha(
                                            50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        delay,
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
                                icon: LucideIcons.percent,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SliderTheme(
                                        data: sliderThemeData,
                                        child: Slider(
                                          value:
                                              double.tryParse(
                                                distance.replaceAll('m', ''),
                                              ) ??
                                              1.0,
                                          min: 0.5,
                                          max: 3.0,
                                          onChanged: (val) => setState(
                                            () => distance =
                                                '${val.toStringAsFixed(1)}m',
                                          ),
                                          activeColor: Colors.red,
                                          inactiveColor: Colors.red.withAlpha(
                                            50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        distance,
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
                                icon: LucideIcons.camera,
                                inline: true,
                                child: Checkbox(
                                  value: camera,
                                  onChanged: (val) =>
                                      setState(() => camera = val!),
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
                        // Vertical divider
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              MySettingRow(
                                label: 'Sound',
                                icon: LucideIcons.volume2,
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
                                          inactiveColor: Colors.red.withAlpha(
                                            50,
                                          ),
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
                                icon: LucideIcons.vibrate,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SliderTheme(
                                        data: sliderThemeData,
                                        child: Slider(
                                          value: vibration ? 1.0 : 0.0,
                                          divisions: 1,
                                          onChanged: (val) => setState(
                                            () => vibration = val > 0.5,
                                          ),
                                          activeColor: Colors.red,
                                          inactiveColor: Colors.red.withAlpha(
                                            50,
                                          ),
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
                                icon: LucideIcons.mapPin,
                                inline: true,
                                child: Checkbox(
                                  value: location,
                                  onChanged: (val) =>
                                      setState(() => location = val!),
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
                    const SizedBox(height: 24),

                    // Challenge dropdown (spanning full width)
                    MySettingRow(
                      label: 'Challenge',
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.background(context),
                          border: Border.all(color: Colors.red, width: 1.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<ChallengeType>(
                                  value: challengeType,
                                  items: ChallengeType.values
                                      .map(
                                        (c) => DropdownMenuItem(
                                          value: c,
                                          child: Text(
                                            c.label,
                                            style: TextStyle(
                                              color: AppColors.primaryText(context),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => challengeType = val!),
                                  dropdownColor: AppColors.dropdownSurface(context),
                                  icon: const SizedBox.shrink(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              LucideIcons.shield,
                              color: Colors.red,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (challengeType == ChallengeType.pin && !pinConfigured)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          'No PIN set yet - set one in Settings > Security.',
                          style: TextStyle(color: AppColors.secondaryText(context), fontSize: 11),
                        ),
                      ),
                    if (challengeType == ChallengeType.digitCode && !digitCodeConfigured)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          'No Digit Code set yet - set one in Settings > Security.',
                          style: TextStyle(color: AppColors.secondaryText(context), fontSize: 11),
                        ),
                      ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          onSave(
                            title: titleController.text.trim(),
                            vibration: vibration,
                            challengeType: challengeType.name,
                            camera: camera,
                            location: location,
                            volume: volume,
                            sound: sound,
                            distance: distance,
                            delay: delay,
                            mode: mode,
                          );
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
