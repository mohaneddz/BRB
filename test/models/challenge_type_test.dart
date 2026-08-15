import 'package:flutter_test/flutter_test.dart';
import 'package:brb/models/challenge_type.dart';

void main() {
  group('ChallengeType', () {
    test('fromName round-trips every value\'s own name', () {
      for (final type in ChallengeType.values) {
        expect(ChallengeType.fromName(type.name), type);
      }
    });

    test('fromName falls back to none for unknown/null input', () {
      expect(ChallengeType.fromName('bogus'), ChallengeType.none);
      expect(ChallengeType.fromName(null), ChallengeType.none);
    });

    test('fromLabel maps the dropdown labels back to the right type', () {
      expect(ChallengeType.fromLabel('PIN'), ChallengeType.pin);
      expect(ChallengeType.fromLabel('Digit Code'), ChallengeType.digitCode);
      expect(ChallengeType.fromLabel('None'), ChallengeType.none);
      expect(ChallengeType.fromLabel('anything else'), ChallengeType.none);
    });

    test('label is human-readable for each type', () {
      expect(ChallengeType.none.label, 'None');
      expect(ChallengeType.pin.label, 'PIN');
      expect(ChallengeType.digitCode.label, 'Digit Code');
    });
  });
}
