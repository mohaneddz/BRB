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
  final List<String> modes = ['Pocket', 'Sensitive', 'Distant', 'Steps'];

  List<Map<String, dynamic>> presets = [
    {
      'title': 'GYM',
      'vibration': true,
      'lock': false,
      'camera': false,
      'location': false,
      'volume': 0.5,
      'sound': 0.7,
      'distance': '2m',
      'delay': '3s',
      'mode': 'Pocket',
      'lastUsed': '2 hours ago',
    },
    {
      'title': 'WORK',
      'vibration': false,
      'lock': true,
      'camera': false,
      'location': false,
      'volume': 0.8,
      'sound': 0.6,
      'distance': '1m',
      'delay': '2s',
      'mode': 'Sensitive',
      'lastUsed': 'Yesterday',
    },
  ];

  void _addPreset() {
    showPresetModal(
      context: context,
      initialCamera: false,
      initialLocation: false,
      onSave:
          ({
            required String title,
            required bool vibration,
            required bool lock,
            required bool camera,
            required bool location,
            required double volume,
            required double sound,
            required String distance,
            required String delay,
            required String mode,
          }) {
            setState(() {
              presets.add({
                'title': title,
                'vibration': vibration,
                'lock': lock,
                'camera': camera,
                'location': location,
                'volume': volume,
                'sound': sound,
                'distance': distance,
                'delay': delay,
                'mode': mode,
                'lastUsed': 'Never',
              });
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
      initialCamera: preset['camera'] ?? false,
      initialLocation: preset['location'] ?? false,
      initialVolume: preset['volume'],
      initialSound: preset['sound'],
      initialDistance: preset['distance'],
      initialDelay: preset['delay'],
      initialMode: preset['mode'] ?? 'Pocket',
      onSave:
          ({
            required String title,
            required bool vibration,
            required bool lock,
            required bool camera,
            required bool location,
            required double volume,
            required double sound,
            required String distance,
            required String delay,
            required String mode,
          }) {
            setState(() {
              presets[index] = {
                'title': title,
                'vibration': vibration,
                'lock': lock,
                'camera': camera,
                'location': location,
                'volume': volume,
                'sound': sound,
                'distance': distance,
                'delay': delay,
                'mode': mode,
                'lastUsed':
                    presets[index]['lastUsed'], // Preserve existing lastUsed
              };
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
                  lastUsed: presets[i]['lastUsed'],
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
