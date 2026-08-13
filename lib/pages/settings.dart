import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/utils/settings_utis.dart';
import 'package:brb/utils/tools/pin_service.dart';
import 'package:brb/utils/theme_controller.dart';
import 'package:brb/utils/movement_utils.dart';

import 'package:lucide_icons/lucide_icons.dart';

import 'package:brb/components/settings/sensitivity_slider_section.dart';
import 'package:brb/components/settings/detection_delay_slider_section.dart';
import 'package:brb/components/settings/steps_threshold_slider_section.dart';
import 'package:brb/components/settings/max_distance_slider_section.dart';
import 'package:brb/components/settings/alarm_tone_selector_section.dart';
import 'package:brb/components/settings/alarm_sound_picker_section.dart';
import 'package:brb/components/settings/language_selector_section.dart';
import 'package:brb/components/settings/custom_pin_section.dart';
import 'package:brb/components/settings/settings_tiles.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SettingsService _settingsService = SettingsService();
  final PinService _pinService = PinService();
  final TextEditingController _pinController = TextEditingController();
  late final SharedPreferences _prefs;
  bool _isLoading = true;
  bool _pinEnabled = false;
  bool _pinObscured = true;

  // General
  bool _darkModeEnabled = true;
  String _selectedLanguage = 'English';
  bool _floatingNotificationsEnabled = true;
  final List<String> _languages = ['English', 'French'];

  // Detection
  double _sensitivity = 0.5;
  double _activeDelay = 1.0;
  int _stepsThreshold = 3;
  double _maxDistanceMeters = 5.0;

  // Alarm
  bool _soundEnabled = true;
  bool _vibrateEnabled = true;
  String _selectedAlarmTone = 'Security Alert';
  String? _customToneName;
  final List<String> _alarmTones = [
    'Security Alert',
    'Siren',
    'Loud Beep',
    'Emergency',
    'Classic Alarm',
  ];

  // Functions
  bool _locationEnabled = true;
  bool _cameraEnabled = true;
  bool _microphoneEnabled = true;

  @override
  void initState() {
    super.initState();
    _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    await _settingsService.init();
    _prefs = await SharedPreferences.getInstance();
    _pinEnabled = _pinService.isEnabled(_prefs);
    _pinController.text = _pinService.getPin(_prefs) ?? '';
    String lang = _settingsService.getLanguage();
    if (lang == 'en') lang = 'English';
    if (lang == 'fr') lang = 'French';
    if (!_languages.contains(lang)) lang = 'English';
    setState(() {
      _darkModeEnabled = _settingsService.getDarkMode();
      _selectedLanguage = lang;
      _floatingNotificationsEnabled = _settingsService
          .getFloatingNotifications();
      _sensitivity = _settingsService.getMotionSensitivity();
      _activeDelay = _settingsService.getActiveDelay();
      _stepsThreshold = _settingsService.getStepsThreshold();
      _maxDistanceMeters = _settingsService.getMaxDistanceMeters();
      _soundEnabled = _settingsService.isSoundEnabled();
      _vibrateEnabled = _settingsService.isVibrationEnabled();
      _selectedAlarmTone = _settingsService.getAlarmTone();
      _customToneName = _settingsService.getAlarmToneName();
      _locationEnabled = _settingsService.isLocationServiceEnabled();
      _cameraEnabled = _settingsService.isCameraAccessEnabled();
      _microphoneEnabled = _settingsService.isMicrophoneAccessEnabled();
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General
            _buildSectionHeader('General'),
            SwitchTile(
              title: 'Dark Mode',
              value: _darkModeEnabled,
              onChanged: (value) async {
                setState(() => _darkModeEnabled = value);
                themeModeNotifier.value = value
                    ? ThemeMode.dark
                    : ThemeMode.light;
                await _settingsService.setDarkMode(value);
              },
              icon: LucideIcons.moon,
            ),
            SwitchTile(
              title: 'Floating Notifications',
              value: _floatingNotificationsEnabled,
              onChanged: (value) async {
                setState(() => _floatingNotificationsEnabled = value);
                await _settingsService.setFloatingNotifications(value);
              },
              icon: LucideIcons.bell,
            ),
            LanguageSelectorSection(
              selectedLanguage: _selectedLanguage,
              languages: _languages,
              onChanged: (value) async {
                if (value != null) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                  await _settingsService.setLanguage(value);
                }
              },
            ),
            const SizedBox(height: 24),
            // Detection
            _buildSectionHeader('Detection'),
            SensitivitySliderSection(
              sensitivity: _sensitivity,
              onChanged: (value) async {
                setState(() => _sensitivity = value);
                await _settingsService.setMotionSensitivity(value);
              },
            ),
            DetectionDelaySliderSection(
              detectionDelay: _activeDelay,
              onChanged: (value) async {
                setState(() => _activeDelay = value);
                await _settingsService.setActiveDelay(value);
              },
            ),
            StepsThresholdSliderSection(
              stepsThreshold: _stepsThreshold,
              onChanged: (value) async {
                setState(() => _stepsThreshold = value);
                await _settingsService.setStepsThreshold(value);
              },
            ),
            MaxDistanceSliderSection(
              maxDistanceMeters: _maxDistanceMeters,
              onChanged: (value) async {
                setState(() => _maxDistanceMeters = value);
                await _settingsService.setMaxDistanceMeters(value);
              },
            ),
            const SizedBox(height: 24),

            // Alarm
            _buildSectionHeader('Alarm'),
            AlarmToneSelectorSection(
              selectedAlarmTone: _selectedAlarmTone,
              alarmTones: _alarmTones,
              onChanged: (value) async {
                if (value != null) {
                  setState(() => _selectedAlarmTone = value);
                  await _settingsService.setAlarmTone(value);
                }
              },
            ),
            AlarmSoundPickerSection(
              customToneName: _customToneName,
              onPickFile: _pickAlarmSound,
              onClear: _clearAlarmSound,
            ),
            SwitchTile(
              title: 'Sound Enabled',
              value: _soundEnabled,
              onChanged: (value) async {
                setState(() => _soundEnabled = value);
                await _settingsService.setSoundEnabled(value);
              },
              icon: LucideIcons.volume2,
            ),
            SwitchTile(
              title: 'Vibrate',
              value: _vibrateEnabled,
              onChanged: (value) async {
                setState(() => _vibrateEnabled = value);
                await _settingsService.setVibrationEnabled(value);
              },
              icon: LucideIcons.vibrate,
            ),
            const SizedBox(height: 24),

            // Security
            _buildSectionHeader('Security'),
            CustomPinSection(
              enabled: _pinEnabled,
              pinController: _pinController,
              obscurePin: _pinObscured,
              onToggle: (value) async {
                setState(() => _pinEnabled = value);
                await _pinService.setEnabled(_prefs, value);
              },
              onToggleObscure: () =>
                  setState(() => _pinObscured = !_pinObscured),
              onPinChanged: (value) async {
                await _pinService.setPin(_prefs, value);
              },
            ),
            const SizedBox(height: 24),

            // Functions
            _buildSectionHeader('Functions'),
            SwitchTile(
              title: 'Location Service',
              value: _locationEnabled,
              onChanged: (value) async {
                setState(() => _locationEnabled = value);
                await _settingsService.setLocationServiceEnabled(value);
              },
              icon: LucideIcons.mapPin,
            ),
            SwitchTile(
              title: 'Camera Access',
              value: _cameraEnabled,
              onChanged: (value) async {
                setState(() => _cameraEnabled = value);
                await _settingsService.setCameraAccessEnabled(value);
              },
              icon: LucideIcons.camera,
            ),
            SwitchTile(
              title: 'Microphone Access',
              value: _microphoneEnabled,
              onChanged: (value) async {
                setState(() => _microphoneEnabled = value);
                await _settingsService.setMicrophoneAccessEnabled(value);
              },
              icon: LucideIcons.mic,
            ),
            ActionTile(
              title: 'Sensor Diagnostics',
              subtitle: 'Live readout of every sensor BRB uses',
              icon: LucideIcons.activity,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SensorDashboardPage()),
              ),
            ),
            const SizedBox(height: 24),

            // Support
            _buildSectionHeader('Support'),
            ActionTile(
              title: 'Star on GitHub',
              subtitle: 'Help us grow by starring the project!',
              icon: LucideIcons.github,
              onTap: () => _showGitHubDialog(),
            ),
            ActionTile(
              title: 'Report Issue',
              subtitle: 'Found a bug? Let us know',
              icon: LucideIcons.bug,
              onTap: () => _showReportDialog(),
            ),
            ActionTile(
              title: 'Help & FAQ',
              subtitle: 'Get help using BRB',
              icon: LucideIcons.helpCircle,
              onTap: () => _showHelpDialog(),
            ),
            const SizedBox(height: 24),

            // About
            _buildSectionHeader('About'),
            InfoTile(title: 'Version', value: '1.0.0'),
            InfoTile(title: 'Build', value: '2025.07.09'),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAlarmSound() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    final picked = result?.files.single;
    if (picked == null || picked.path == null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final ext = picked.extension != null ? '.${picked.extension}' : '';
    final fileName = 'alarm_tone_${DateTime.now().millisecondsSinceEpoch}$ext';
    final saved = await File(picked.path!).copy('${appDir.path}/$fileName');

    await _settingsService.setAlarmTonePath(saved.path, picked.name);
    if (!mounted) return;
    setState(() => _customToneName = picked.name);
  }

  Future<void> _clearAlarmSound() async {
    await _settingsService.clearAlarmTonePath();
    if (!mounted) return;
    setState(() => _customToneName = null);
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.accent,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showGitHubDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Star on GitHub'),
        content: const Text(
          'Help us grow by starring the BRB project on GitHub! Your support means everything to us.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Later', style: TextStyle(color: AppColors.secondaryText(context))),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await launchUrl(
                Uri.parse('https://github.com/mohaneddz/BRB'),
                mode: LaunchMode.externalApplication,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Star Now'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Issue'),
        content: const Text(
          'Found a bug or have a suggestion? We\'d love to hear from you!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.secondaryText(context))),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await launchUrl(
                Uri.parse('https://github.com/mohaneddz/BRB/issues/new'),
                mode: LaunchMode.externalApplication,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & FAQ'),
        content: const Text(
          'Need help using BRB? Check out our documentation and frequently asked questions.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.secondaryText(context))),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await launchUrl(
                Uri.parse('https://github.com/mohaneddz/BRB#readme'),
                mode: LaunchMode.externalApplication,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
            child: const Text('View Help'),
          ),
        ],
      ),
    );
  }
}
