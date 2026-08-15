import 'package:flutter_test/flutter_test.dart';
import 'package:brb/models/preset.dart';

Preset _sample({String challengeType = 'pin', bool mic = true}) => Preset(
  title: 'GYM',
  vibration: true,
  challengeType: challengeType,
  camera: true,
  location: false,
  mic: mic,
  volume: 0.5,
  sound: 0.7,
  distance: '2m',
  delay: '3s',
  mode: 'Pocket',
  lastUsed: 'Never',
);

void main() {
  group('Preset JSON round-trip', () {
    test('toJson/fromJson preserves every field', () {
      final preset = _sample();
      final restored = Preset.fromJson(preset.toJson());

      expect(restored.title, preset.title);
      expect(restored.vibration, preset.vibration);
      expect(restored.challengeType, preset.challengeType);
      expect(restored.camera, preset.camera);
      expect(restored.location, preset.location);
      expect(restored.mic, preset.mic);
      expect(restored.volume, preset.volume);
      expect(restored.sound, preset.sound);
      expect(restored.distance, preset.distance);
      expect(restored.delay, preset.delay);
      expect(restored.mode, preset.mode);
      expect(restored.lastUsed, preset.lastUsed);
    });

    test('fromJson defaults challengeType to none for pre-challenge-system data', () {
      final legacyJson = _sample().toJson()..remove('challengeType');
      final restored = Preset.fromJson(legacyJson);
      expect(restored.challengeType, 'none');
    });

    test('fromJson defaults mic to false when missing (pre-microphone data)', () {
      final legacyJson = _sample().toJson()..remove('mic');
      final restored = Preset.fromJson(legacyJson);
      expect(restored.mic, false);
    });

    test('a bare constructor call defaults mic to false', () {
      const preset = Preset(
        title: 'WORK',
        vibration: false,
        challengeType: 'none',
        camera: false,
        location: false,
        volume: 0.5,
        sound: 0.5,
        distance: '1m',
        delay: '1s',
        mode: 'Sensitive',
        lastUsed: 'Never',
      );
      expect(preset.mic, false);
    });
  });

  group('Preset.copyWith', () {
    test('overrides only the given fields', () {
      final preset = _sample(challengeType: 'none');
      final updated = preset.copyWith(challengeType: 'digitCode', mic: false);

      expect(updated.challengeType, 'digitCode');
      expect(updated.mic, false);
      // Everything else stays the same as the source preset.
      expect(updated.title, preset.title);
      expect(updated.camera, preset.camera);
      expect(updated.mode, preset.mode);
    });
  });
}
