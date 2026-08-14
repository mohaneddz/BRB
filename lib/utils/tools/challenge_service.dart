import 'package:shared_preferences/shared_preferences.dart';

/// Manages the secret codes used to gate alarm dismissal. A preset picks
/// which challenge (if any) applies via [ChallengeType]; this service holds
/// the actual secret values configured once in Settings.
class ChallengeService {
  static const _pinEnabledKey = 'pin_enabled';
  static const _pinKey = 'pin_code';
  static const _digitCodeEnabledKey = 'digit_code_enabled';
  static const _digitCodeKey = 'digit_code';

  bool isPinEnabled(SharedPreferences prefs) =>
      prefs.getBool(_pinEnabledKey) ?? false;

  Future<void> setPinEnabled(SharedPreferences prefs, bool value) async {
    await prefs.setBool(_pinEnabledKey, value);
  }

  String? getPin(SharedPreferences prefs) => prefs.getString(_pinKey);

  Future<void> setPin(SharedPreferences prefs, String pin) async {
    await prefs.setString(_pinKey, pin);
  }

  bool verifyPin(SharedPreferences prefs, String candidate) {
    final stored = getPin(prefs);
    return stored != null && stored == candidate;
  }

  bool isDigitCodeEnabled(SharedPreferences prefs) =>
      prefs.getBool(_digitCodeEnabledKey) ?? false;

  Future<void> setDigitCodeEnabled(SharedPreferences prefs, bool value) async {
    await prefs.setBool(_digitCodeEnabledKey, value);
  }

  String? getDigitCode(SharedPreferences prefs) =>
      prefs.getString(_digitCodeKey);

  Future<void> setDigitCode(SharedPreferences prefs, String code) async {
    await prefs.setString(_digitCodeKey, code);
  }

  bool verifyDigitCode(SharedPreferences prefs, String candidate) {
    final stored = getDigitCode(prefs);
    return stored != null && stored == candidate;
  }
}
