import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/components/ui/my_dropdown.dart';
import 'package:brb/components/ui/my_setting_row.dart';
import 'package:lucide_icons/lucide_icons.dart';

Future<void> showPresetModal({
  required BuildContext context,
  String? initialTitle,
  bool initialVibration = true,
  bool initialLock = true,
  double initialVolume = 0.5,
  double initialSound = 0.5,
  String initialDistance = '1m',
  String initialDelay = '1s',
  required void Function({required String title, required bool vibration, required bool lock, required double volume, required double sound, required String distance, required String delay}) onSave,
}) async {
  final titleController = TextEditingController(text: initialTitle ?? '');
  bool vibration = initialVibration;
  bool lock = initialLock;
  double volume = initialVolume;
  double sound = initialSound;
  String distance = initialDistance;
  String delay = initialDelay;

  final distances = ['1m', '2m', '3m'];
  final delays = ['1s', '2s', '3s'];

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.darkBgLight, // Ensures modal uses darkBgLight color
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (context) {
      return Container(
        color: AppColors.darkBgLight, // Also set the inner container color
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      initialTitle == null ? 'Add Preset' : 'Edit Preset',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    MySettingRow(
                      label: 'Distance',
                      child: Row(
                        children: [
                          const Icon(LucideIcons.ruler, color: Colors.red, size: 20),
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            width: 100,
                            child: MyDropdown(value: distance, items: distances, onChanged: (val) => setState(() => distance = val!)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    MySettingRow(
                      label: 'Vibration',
                      child: Checkbox(
                        value: vibration,
                        onChanged: (val) => setState(() => vibration = val!),
                        activeColor: Colors.red,
                        checkColor: Colors.white,
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 12),
                    MySettingRow(
                      width: 100,
                      label: 'Volume',
                      child: SizedBox(
                        width: 140,
                        child: Slider(value: volume, onChanged: (val) => setState(() => volume = val), activeColor: Colors.red, inactiveColor: Colors.red.withAlpha(3)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    MySettingRow(
                      label: 'Delay',
                      child: Row(
                        children: [
                          const Icon(LucideIcons.timer, color: Colors.red, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: MyDropdown(value: delay, items: delays, onChanged: (val) => setState(() => delay = val!)),
                          ),
                          // Add the icon on the right for Delay
                          const SizedBox(width: 8),
                          const Icon(LucideIcons.arrowRight, color: Colors.red, size: 20), // Example icon, change as needed
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    MySettingRow(
                      label: 'Lock',
                      child: Checkbox(
                        value: lock,
                        onChanged: (val) => setState(() => lock = val!),
                        activeColor: Colors.red,
                        checkColor: Colors.white,
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 12),
                    MySettingRow(
                      width: 100,
                      label: 'Sound',
                      child: SizedBox(
                        width: 140,
                        child: Slider(value: sound, onChanged: (val) => setState(() => sound = val), activeColor: Colors.red, inactiveColor: Colors.red.withAlpha(3)),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          onSave(title: titleController.text.trim(), vibration: vibration, lock: lock, volume: volume, sound: sound, distance: distance, delay: delay);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
