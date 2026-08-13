import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/components/presets/preset_card.dart';
import 'package:brb/components/presets/preset_modal.dart';
import 'package:brb/components/presets/add_preset_button.dart';
import 'package:brb/models/preset.dart';
import 'package:brb/utils/settings_utis.dart';
import 'package:brb/utils/tools/presets_service.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Presets extends StatefulWidget {
  const Presets({super.key});

  @override
  State<Presets> createState() => _PresetsState();
}

class _PresetsState extends State<Presets> {
  final PresetsService _presetsService = PresetsService();
  final SettingsService _settingsService = SettingsService();
  late final SharedPreferences _prefs;

  List<Preset> presets = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _prefs = await SharedPreferences.getInstance();
    await _settingsService.init();
    setState(() {
      presets = _presetsService.load(_prefs);
      _loading = false;
    });
  }

  Future<void> _persist() => _presetsService.save(_prefs, presets);

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
              presets.add(
                Preset(
                  title: title,
                  vibration: vibration,
                  lock: lock,
                  camera: camera,
                  location: location,
                  volume: volume,
                  sound: sound,
                  distance: distance,
                  delay: delay,
                  mode: mode,
                  lastUsed: 'Never',
                ),
              );
            });
            _persist();
          },
    );
  }

  void _editPreset(int index) {
    final preset = presets[index];
    showPresetModal(
      context: context,
      initialTitle: preset.title,
      initialVibration: preset.vibration,
      initialLock: preset.lock,
      initialCamera: preset.camera,
      initialLocation: preset.location,
      initialVolume: preset.volume,
      initialSound: preset.sound,
      initialDistance: preset.distance,
      initialDelay: preset.delay,
      initialMode: preset.mode,
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
              presets[index] = preset.copyWith(
                title: title,
                vibration: vibration,
                lock: lock,
                camera: camera,
                location: location,
                volume: volume,
                sound: sound,
                distance: distance,
                delay: delay,
                mode: mode,
              );
            });
            _persist();
          },
    );
  }

  void _deletePreset(int index) {
    setState(() => presets.removeAt(index));
    _persist();
  }

  /// Applies a preset as the Home screen's active configuration and pops
  /// back so the user lands on Home with it in effect.
  Future<void> _applyPreset(int index) async {
    final preset = presets[index];
    final delaySeconds =
        double.tryParse(preset.delay.replaceAll('s', '')) ?? 1.0;
    final distanceMeters =
        double.tryParse(preset.distance.replaceAll('m', '')) ?? 1.0;
    // Inverse of the grace * maxDistanceMeters mapping Home uses for
    // Distant mode - keep in sync with DetectionService arming in home.dart.
    final maxDistance = _settingsService.getMaxDistanceMeters();
    final grace = maxDistance > 0
        ? (distanceMeters / maxDistance).clamp(0.0, 1.0)
        : 0.0;

    await _settingsService.setActiveMode(preset.mode);
    await _settingsService.setActiveDelay(delaySeconds);
    await _settingsService.setActiveGrace(grace);
    await _settingsService.setActiveCameraEnabled(preset.camera);
    await _settingsService.setActiveLocationEnabled(preset.location);
    await _settingsService.setActiveSound(preset.sound);
    await _settingsService.setActiveVibrationConfig(preset.vibration);

    setState(() {
      presets[index] = preset.copyWith(lastUsed: 'Just now');
    });
    await _persist();

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${preset.title} applied')));
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presets'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: 'Back',
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            )
          : presets.isEmpty
          ? Center(
              child: Text(
                'No presets yet.\nTap + to create one.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.secondaryText(context)),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: List.generate(
                presets.length,
                (i) => PresetCard(
                  title: presets[i].title,
                  lastUsed: presets[i].lastUsed,
                  onTap: () => _applyPreset(i),
                  onEdit: () => _editPreset(i),
                  onDelete: () => _deletePreset(i),
                ),
              ),
            ),
      floatingActionButton: AddPresetButton(onPressed: _addPreset),
    );
  }
}
