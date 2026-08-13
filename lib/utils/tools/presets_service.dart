import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brb/models/preset.dart';

class PresetsService {
  static const _key = 'presets_v1';

  List<Preset> load(SharedPreferences prefs) {
    final raw = prefs.getString(_key);
    if (raw == null) return _defaults();
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => Preset.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(SharedPreferences prefs, List<Preset> presets) async {
    final encoded = jsonEncode(presets.map((p) => p.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  List<Preset> _defaults() => const [
    Preset(
      title: 'GYM',
      vibration: true,
      lock: false,
      camera: false,
      location: false,
      volume: 0.5,
      sound: 0.7,
      distance: '2m',
      delay: '3s',
      mode: 'Pocket',
      lastUsed: 'Never',
    ),
    Preset(
      title: 'WORK',
      vibration: false,
      lock: true,
      camera: false,
      location: false,
      volume: 0.8,
      sound: 0.6,
      distance: '1m',
      delay: '2s',
      mode: 'Sensitive',
      lastUsed: 'Never',
    ),
  ];
}
