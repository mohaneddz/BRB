import 'package:shared_preferences/shared_preferences.dart';

class PinService {
  static const _enabledKey = 'pin_enabled';
  static const _pinKey = 'pin_code';

  bool isEnabled(SharedPreferences prefs) => prefs.getBool(_enabledKey) ?? false;

  Future<void> setEnabled(SharedPreferences prefs, bool value) async {
    await prefs.setBool(_enabledKey, value);
  }

  String? getPin(SharedPreferences prefs) => prefs.getString(_pinKey);

  Future<void> setPin(SharedPreferences prefs, String pin) async {
    await prefs.setString(_pinKey, pin);
  }

  bool verify(SharedPreferences prefs, String candidate) {
    final stored = getPin(prefs);
    return stored != null && stored == candidate;
  }
}
