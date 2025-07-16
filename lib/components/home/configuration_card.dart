import 'package:brb/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:brb/components/ui/dropdown.dart';
import 'package:brb/components/home/settings_row.dart';
import 'package:brb/pages/presets.dart';

class ConfigurationCard extends StatefulWidget {
  const ConfigurationCard({super.key});

  @override
  State<ConfigurationCard> createState() => ConfigurationCardState();
}

class ConfigurationCardState extends State<ConfigurationCard> {
  bool vibration = true;
  bool lock = true;
  double volume = 0.5;
  double sound = 0.5;
  String distance = '1m';
  String delay = '1s';

  final List<String> distances = ['1m', '2m', '3m'];
  final List<String> delays = ['1s', '2s', '3s'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title ------------------------------------------
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Center(
            child: Text(
              'Current Configuration',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        // Configuration Card ------------------------------------------
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkBgLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red, width: 2),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    // Left column ------------------------------------------
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Distance
                          MySettingRow(
                            label: 'Distance',
                            child: MyDropdown(value: distance, items: distances, onChanged: (val) => setState(() => distance = val!)),
                          ),
                          const SizedBox(height: 12),
                          // Vibration
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
                          // Volume
                          MySettingRow(
                            label: 'Volume',
                            width: 75,
                            child: Slider(value: volume, onChanged: (val) => setState(() => volume = val), activeColor: Colors.red, inactiveColor: Colors.red.withAlpha(3)),
                          ),
                        ],
                      ),
                    ),
                    // Divider------------------------------------------
                    Container(width: 1, color: Colors.white24, margin: const EdgeInsets.symmetric(horizontal: 12)),
                    // Right column ------------------------------------------
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Delay
                          MySettingRow(
                            label: 'Delay',
                            child: MyDropdown(value: delay, items: delays, onChanged: (val) => setState(() => delay = val!)),
                          ),
                          const SizedBox(height: 12),
                          // Lock
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
                          const SizedBox(height: 8),
                          // Sound
                          MySettingRow(
                            label: 'Sound',
                            width: 75,
                            child: Slider(value: sound, onChanged: (val) => setState(() => sound = val), activeColor: Colors.red, inactiveColor: Colors.red.withAlpha(3)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Presets button
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Presets()));
                  },
                  child: const Text('Presets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
