import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brb/utils/tools/challenge_service.dart';

void main() {
  late ChallengeService service;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    service = ChallengeService();
  });

  group('PIN', () {
    test('disabled and unset by default', () {
      expect(service.isPinEnabled(prefs), false);
      expect(service.getPin(prefs), isNull);
    });

    test('set + enable persists and verifies correctly', () async {
      await service.setPin(prefs, '4321');
      await service.setPinEnabled(prefs, true);

      expect(service.isPinEnabled(prefs), true);
      expect(service.getPin(prefs), '4321');
      expect(service.verifyPin(prefs, '4321'), true);
      expect(service.verifyPin(prefs, '0000'), false);
    });

    test('verifyPin is false when no PIN has been set', () {
      expect(service.verifyPin(prefs, '4321'), false);
    });
  });

  group('Digit Code', () {
    test('disabled and unset by default', () {
      expect(service.isDigitCodeEnabled(prefs), false);
      expect(service.getDigitCode(prefs), isNull);
    });

    test('set + enable persists and verifies correctly', () async {
      await service.setDigitCode(prefs, '9999');
      await service.setDigitCodeEnabled(prefs, true);

      expect(service.isDigitCodeEnabled(prefs), true);
      expect(service.getDigitCode(prefs), '9999');
      expect(service.verifyDigitCode(prefs, '9999'), true);
      expect(service.verifyDigitCode(prefs, '1111'), false);
    });
  });

  test('PIN and Digit Code secrets are independent of each other', () async {
    await service.setPin(prefs, '1111');
    await service.setDigitCode(prefs, '2222');

    expect(service.getPin(prefs), '1111');
    expect(service.getDigitCode(prefs), '2222');
    expect(service.verifyPin(prefs, '2222'), false);
    expect(service.verifyDigitCode(prefs, '1111'), false);
  });
}
