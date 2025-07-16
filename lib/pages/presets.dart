import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/components/presets/preset_card.dart';
import 'package:brb/components/presets/preset_modal.dart';
import 'package:brb/components/presets/add_preset_button.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Presets extends StatefulWidget {
  const Presets({super.key});

  @override
  State<Presets> createState() => _PresetsState();
}

class _PresetsState extends State<Presets> {
  List<Map<String, dynamic>> presets = [
    {'title': 'GYM', 'vibration': true, 'lock': false, 'volume': 0.5, 'sound': 0.7, 'distance': '2m', 'delay': '3s'},
    {'title': 'WORK', 'vibration': false, 'lock': true, 'volume': 0.8, 'sound': 0.6, 'distance': '1m', 'delay': '2s'},
  ];

  void _addPreset() {
    showPresetModal(
      context: context,
      onSave:
          ({
            required String title,
            required bool vibration,
            required bool lock,
            required double volume,
            required double sound,
            required String distance,
            required String delay,
          }) {
            setState(() {
              presets.add({'title': title, 'vibration': vibration, 'lock': lock, 'volume': volume, 'sound': sound, 'distance': distance, 'delay': delay});
            });
          },
    );
  }

  void _editPreset(int index) {
    final preset = presets[index];
    showPresetModal(
      context: context,
      initialTitle: preset['title'],
      initialVibration: preset['vibration'],
      initialLock: preset['lock'],
      initialVolume: preset['volume'],
      initialSound: preset['sound'],
      initialDistance: preset['distance'],
      initialDelay: preset['delay'],
      onSave:
          ({
            required String title,
            required bool vibration,
            required bool lock,
            required double volume,
            required double sound,
            required String distance,
            required String delay,
          }) {
            setState(() {
              presets[index] = {'title': title, 'vibration': vibration, 'lock': lock, 'volume': volume, 'sound': sound, 'distance': distance, 'delay': delay};
            });
          },
    );
  }

  void _deletePreset(int index) {
    setState(() {
      presets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBgLight,
        title: const Text('Presets'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: 'Back',
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings, color: Colors.white),
            onPressed: () {
              // TODO: Implement settings action
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...List.generate(
                presets.length,
                (i) => PresetCard(
                  title: presets[i]['title'],
                  vibration: presets[i]['vibration'],
                  lock: presets[i]['lock'],
                  volume: presets[i]['volume'],
                  sound: presets[i]['sound'],
                  distance: presets[i]['distance'],
                  delay: presets[i]['delay'],
                  onEdit: () => _editPreset(i),
                  onDelete: () => _deletePreset(i),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AddPresetButton(onPressed: _addPreset),
    );
  }
}
