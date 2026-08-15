import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brb/models/preset.dart';
import 'package:brb/utils/tools/presets_service.dart';

void main() {
  late PresetsService service;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    service = PresetsService();
  });

  test('load() on a fresh install returns the GYM/WORK defaults', () {
    final presets = service.load(prefs);
    expect(presets.map((p) => p.title), containsAll(['GYM', 'WORK']));
    expect(presets.every((p) => p.challengeType == 'none'), true);
  });

  test(
    'the default list returned by load() is mutable in place - '
    'regression test for the "Cannot modify an unmodifiable list" crash '
    '(PresetsService._defaults() used to be a const list)',
    () {
      final presets = service.load(prefs);
      expect(
        () => presets[0] = presets[0].copyWith(lastUsed: 'Just now'),
        returnsNormally,
      );
      expect(presets[0].lastUsed, 'Just now');
    },
  );

  test('save() then load() round-trips a modified preset list', () async {
    final presets = service.load(prefs);
    presets[0] = presets[0].copyWith(lastUsed: 'Just now', challengeType: 'pin');
    await service.save(prefs, presets);

    final reloaded = service.load(prefs);
    expect(reloaded[0].lastUsed, 'Just now');
    expect(reloaded[0].challengeType, 'pin');
  });

  test('save() persists an entirely custom preset list, not just defaults', () async {
    final custom = [
      const Preset(
        title: 'CUSTOM',
        vibration: false,
        challengeType: 'digitCode',
        camera: true,
        location: true,
        mic: true,
        volume: 0.9,
        sound: 0.9,
        distance: '3m',
        delay: '5s',
        mode: 'Distant',
        lastUsed: 'Never',
      ),
    ];
    await service.save(prefs, custom);

    final reloaded = service.load(prefs);
    expect(reloaded.length, 1);
    expect(reloaded.single.title, 'CUSTOM');
    expect(reloaded.single.mic, true);
  });
}
