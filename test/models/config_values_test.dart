import 'package:flutter_test/flutter_test.dart';
import 'package:brb/models/config_values.dart';

void main() {
  group('ConfigValues', () {
    test('defaults are sane out-of-the-box arm values', () {
      const defaults = ConfigValues.defaults;
      expect(defaults.mode, 'Pocket');
      expect(defaults.challengeType, 'none');
      expect(defaults.camera, false);
      expect(defaults.location, false);
      expect(defaults.mic, false);
      expect(defaults.vibration, true);
    });

    test('copyWith overrides only the given fields and keeps the rest', () {
      const base = ConfigValues.defaults;
      final updated = base.copyWith(mode: 'Sensitive', challengeType: 'pin');

      expect(updated.mode, 'Sensitive');
      expect(updated.challengeType, 'pin');
      expect(updated.delay, base.delay);
      expect(updated.grace, base.grace);
      expect(updated.camera, base.camera);
      expect(updated.mic, base.mic);
    });

    test('copyWith with no arguments returns an equivalent-valued copy', () {
      const base = ConfigValues.defaults;
      final copy = base.copyWith();
      expect(copy.mode, base.mode);
      expect(copy.delay, base.delay);
      expect(copy.challengeType, base.challengeType);
    });
  });
}
