import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/utils/settings_utis.dart';

import 'package:lucide_icons/lucide_icons.dart';

import 'package:brb/components/settings/sensitivity_slider_section.dart';
import 'package:brb/components/settings/detection_delay_slider_section.dart';
import 'package:brb/components/settings/alarm_tone_selector_section.dart';
import 'package:brb/components/settings/language_selector_section.dart';
import 'package:brb/components/settings/settings_tiles.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SettingsService _settingsService = SettingsService();
  bool _isLoading = true;

  // General
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  bool _floatingNotificationsEnabled = true;
  final List<String> _languages = ['English', 'French'];

  // Detection
  double _sensitivity = 0.5;
  int _detectionFrequency = 3;

  // Alarm
  bool _soundEnabled = true;
  bool _vibrateEnabled = true;
  String _selectedAlarmTone = 'Security Alert';
  final List<String> _alarmTones = [
    'Security Alert',
    'Siren',
    'Loud Beep',
    'Emergency',
    'Classic Alarm',
  ];

  // Functions
  String _firebaseKey = '';
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
      _detectionFrequency = _settingsService.getDetectionFrequency();
      _soundEnabled = _settingsService.isSoundEnabled();
      _vibrateEnabled = _settingsService.isVibrationEnabled();
      _selectedAlarmTone = _settingsService.getAlarmTone();
      _firebaseKey = _settingsService.getFirebaseKey() ?? '';
      _locationEnabled = _settingsService.isLocationServiceEnabled();
      _cameraEnabled = _settingsService.isCameraAccessEnabled();
      _microphoneEnabled = _settingsService.isMicrophoneAccessEnabled();
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.darkBg,
        appBar: AppBar(
          backgroundColor: AppColors.darkBgLight,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBgLight,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
              detectionDelay: _detectionFrequency,
              onChanged: (value) async {
                setState(() => _detectionFrequency = value);
                await _settingsService.setDetectionFrequency(value);
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
        backgroundColor: AppColors.darkBgLight,
        title: const Text(
          'Star on GitHub',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Help us grow by starring the BRB project on GitHub! Your support means everything to us.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              'https://github.com/mohaneddz/brb-flutter';
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
        backgroundColor: AppColors.darkBgLight,
        title: const Text(
          'Report Issue',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Found a bug or have a suggestion? We\'d love to hear from you!',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              'https://github.com/mohaneddz/brb-flutter/issues/new';
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
        backgroundColor: AppColors.darkBgLight,
        title: const Text('Help & FAQ', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Need help using BRB? Check out our documentation and frequently asked questions.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              'https://github.com/mohaneddz/brb-flutter/wiki';
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
