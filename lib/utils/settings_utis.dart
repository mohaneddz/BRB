import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  late final SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // === Dark Mode ===
  bool getDarkMode() => prefs.getBool('dark_mode') ?? false;
  Future<void> setDarkMode(bool value) async => await prefs.setBool('dark_mode', value);

  // === Language ===
  String getLanguage() => prefs.getString('language') ?? 'English';

  // === Floating Notifications ===
  bool getFloatingNotifications() => prefs.getBool('floating_notifications') ?? true;
  Future<void> setFloatingNotifications(bool value) async => await prefs.setBool('floating_notifications', value);
  Future<void> setLanguage(String value) async => await prefs.setString('language', value);

  // === Font Size ===
  int getFontSize() => prefs.getInt('font_size') ?? 16;
  Future<void> setFontSize(int value) async => await prefs.setInt('font_size', value);

  // === PIN ===
  bool hasPin() => prefs.containsKey('custom_pin');
  String? getCustomPin() => prefs.getString('custom_pin');
  Future<void> setCustomPin(String pin) async => await prefs.setString('custom_pin', pin);
  Future<void> removeCustomPin() async => await prefs.remove('custom_pin');
  Future<void> setPinKey(int pin) async => await prefs.setInt('pin_key', pin);

  // === Motion Sensitivity ===
  double getMotionSensitivity() => prefs.getDouble('motion_sensitivity') ?? 0.5;
  Future<void> setMotionSensitivity(double value) async => await prefs.setDouble('motion_sensitivity', value);
  // === Detection Frequency (Frames) ===
  int getDetectionFrequency() => prefs.getInt('detection_frequency') ?? 3;
  Future<void> setDetectionFrequency(int value) async => await prefs.setInt('detection_frequency', value);
  Future<void> setDetectionFrames(int value) async => await prefs.setInt('detection_frames', value);

  // === Sound Enabled ===
  bool isSoundEnabled() => prefs.getBool('sound_enabled') ?? true;
  Future<void> setSoundEnabled(bool value) async => await prefs.setBool('sound_enabled', value);

  // === Vibration Enabled ===
  bool isVibrationEnabled() => prefs.getBool('vibration_enabled') ?? true;
  Future<void> setVibrationEnabled(bool value) async => await prefs.setBool('vibration_enabled', value);
  // === Alarm Tone ===
  String getAlarmTone() => prefs.getString('alarm_tone') ?? 'Security Alert';
  Future<void> setAlarmTone(String value) async => await prefs.setString('alarm_tone', value);

  // === Firebase Key ===
  String? getFirebaseKey() => prefs.getString('firebase_key');
  Future<void> setFirebaseKey(String key) async => await prefs.setString('firebase_key', key);

  // === Location Service ===
  bool isLocationServiceEnabled() => prefs.getBool('location_service_enabled') ?? true;
  Future<void> setLocationServiceEnabled(bool value) async => await prefs.setBool('location_service_enabled', value);

  // === Camera Access ===
  bool isCameraAccessEnabled() => prefs.getBool('camera_access_enabled') ?? true;
  Future<void> setCameraAccessEnabled(bool value) async => await prefs.setBool('camera_access_enabled', value);

  // === Microphone Access ===
  bool isMicrophoneAccessEnabled() => prefs.getBool('microphone_access_enabled') ?? true;
  Future<void> setMicrophoneAccessEnabled(bool value) async => await prefs.setBool('microphone_access_enabled', value);
}
