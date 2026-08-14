import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  late final SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // === Dark Mode === (app ships dark-by-default; toggling off switches to light)
  bool getDarkMode() => prefs.getBool('dark_mode') ?? true;
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

  // === Motion Sensitivity ===
  double getMotionSensitivity() => prefs.getDouble('motion_sensitivity') ?? 0.5;
  Future<void> setMotionSensitivity(double value) async => await prefs.setDouble('motion_sensitivity', value);

  // === Steps Threshold (Steps mode) ===
  int getStepsThreshold() => prefs.getInt('steps_threshold') ?? 3;
  Future<void> setStepsThreshold(int value) async => await prefs.setInt('steps_threshold', value);

  // === Max Distance in meters (Distant mode's Grace slider maps 0..1 onto 0..this) ===
  double getMaxDistanceMeters() => prefs.getDouble('max_distance_meters') ?? 5.0;
  Future<void> setMaxDistanceMeters(double value) async => await prefs.setDouble('max_distance_meters', value);

  // === Sound Enabled ===
  bool isSoundEnabled() => prefs.getBool('sound_enabled') ?? true;
  Future<void> setSoundEnabled(bool value) async => await prefs.setBool('sound_enabled', value);

  // === Vibration Enabled ===
  bool isVibrationEnabled() => prefs.getBool('vibration_enabled') ?? true;
  Future<void> setVibrationEnabled(bool value) async => await prefs.setBool('vibration_enabled', value);
  // === Alarm Tone ===
  String getAlarmTone() => prefs.getString('alarm_tone') ?? 'Security Alert';
  Future<void> setAlarmTone(String value) async => await prefs.setString('alarm_tone', value);

  // === Custom Alarm Sound (picked from device files/ringtones) ===
  // When set, takes priority over the built-in alarm_tone selection.
  String? getAlarmTonePath() => prefs.getString('alarm_tone_path');
  String? getAlarmToneName() => prefs.getString('alarm_tone_path_name');
  Future<void> setAlarmTonePath(String path, String displayName) async {
    await prefs.setString('alarm_tone_path', path);
    await prefs.setString('alarm_tone_path_name', displayName);
  }

  Future<void> clearAlarmTonePath() async {
    await prefs.remove('alarm_tone_path');
    await prefs.remove('alarm_tone_path_name');
  }

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

  // === Active Configuration (Home screen's Current Configuration card) ===
  String getActiveMode() => prefs.getString('active_mode') ?? 'Pocket';
  Future<void> setActiveMode(String value) async => await prefs.setString('active_mode', value);

  double getActiveDelay() => prefs.getDouble('active_delay') ?? 1.0;
  Future<void> setActiveDelay(double value) async => await prefs.setDouble('active_delay', value);

  double getActiveGrace() => prefs.getDouble('active_grace') ?? 0.5;
  Future<void> setActiveGrace(double value) async => await prefs.setDouble('active_grace', value);

  bool getActiveCameraEnabled() => prefs.getBool('active_camera') ?? false;
  Future<void> setActiveCameraEnabled(bool value) async => await prefs.setBool('active_camera', value);

  bool getActiveLocationEnabled() => prefs.getBool('active_location') ?? false;
  Future<void> setActiveLocationEnabled(bool value) async => await prefs.setBool('active_location', value);

  double getActiveSound() => prefs.getDouble('active_sound') ?? 0.5;
  Future<void> setActiveSound(double value) async => await prefs.setDouble('active_sound', value);

  bool getActiveVibrationConfig() => prefs.getBool('active_vibration') ?? true;
  Future<void> setActiveVibrationConfig(bool value) async => await prefs.setBool('active_vibration', value);

  String getActiveChallengeType() => prefs.getString('active_challenge_type') ?? 'none';
  Future<void> setActiveChallengeType(String value) async => await prefs.setString('active_challenge_type', value);

  // === Account Profile ===
  String getFullName() => prefs.getString('profile_full_name') ?? 'Mohaned Manaa';
  Future<void> setFullName(String value) async => await prefs.setString('profile_full_name', value);

  String getUsername() => prefs.getString('profile_username') ?? 'mohaneddz';
  Future<void> setUsername(String value) async => await prefs.setString('profile_username', value);

  String getEmail() => prefs.getString('profile_email') ?? 'mohaneddz@example.com';
  Future<void> setEmail(String value) async => await prefs.setString('profile_email', value);

  String getPhoneNumber() => prefs.getString('profile_phone') ?? '+1 (555) 123-4567';
  Future<void> setPhoneNumber(String value) async => await prefs.setString('profile_phone', value);

  String getBio() => prefs.getString('profile_bio') ?? 'Flutter developer and tech enthusiast';
  Future<void> setBio(String value) async => await prefs.setString('profile_bio', value);
}
