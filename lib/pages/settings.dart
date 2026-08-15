import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:brb/utils/alarm_tones.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/utils/settings_utis.dart';
import 'package:brb/utils/tools/challenge_service.dart';
import 'package:brb/utils/theme_controller.dart';
import 'package:brb/utils/locale_controller.dart';
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
import 'package:brb/l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SettingsService _settingsService = SettingsService();
  final ChallengeService _challengeService = ChallengeService();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _digitCodeController = TextEditingController();
  late final SharedPreferences _prefs;
  bool _isLoading = true;
  bool _pinEnabled = false;
  bool _pinObscured = true;
  bool _digitCodeEnabled = false;
  bool _digitCodeObscured = true;

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

  // About
  String _appVersion = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    await _settingsService.init();
    _prefs = await SharedPreferences.getInstance();
    _pinEnabled = _challengeService.isPinEnabled(_prefs);
    _pinController.text = _challengeService.getPin(_prefs) ?? '';
    _digitCodeEnabled = _challengeService.isDigitCodeEnabled(_prefs);
    _digitCodeController.text = _challengeService.getDigitCode(_prefs) ?? '';
    String lang = _settingsService.getLanguage();
    if (lang == 'en') lang = 'English';
    if (lang == 'fr') lang = 'French';
    if (!_languages.contains(lang)) lang = 'English';
    final packageInfo = await PackageInfo.fromPlatform();
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
      _appVersion = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _digitCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.navSettings,
            style: const TextStyle(fontWeight: FontWeight.bold),
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
        title: Text(l10n.navSettings, style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General
            _buildSectionHeader(l10n.settingsSectionGeneral),
            SwitchTile(
              title: l10n.settingsDarkMode,
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
              title: l10n.settingsFloatingNotifications,
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
                  localeNotifier.value = localeFromLanguageName(value);
                }
              },
            ),
            const SizedBox(height: 24),
            // Detection
            _buildSectionHeader(l10n.settingsSectionDetection),
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
            _buildSectionHeader(l10n.settingsSectionAlarm),
            AlarmToneSelectorSection(
              selectedAlarmTone: _selectedAlarmTone,
              alarmTones: _alarmTones,
              onChanged: (value) async {
                if (value != null) {
                  setState(() => _selectedAlarmTone = value);
                  await _settingsService.setAlarmTone(value);
                }
              },
              onPreview: () async {
                final asset = builtInToneAssets[_selectedAlarmTone];
                if (asset == null) return;
                await AudioPlayer().play(AssetSource(asset));
              },
            ),
            AlarmSoundPickerSection(
              customToneName: _customToneName,
              onPickFile: _pickAlarmSound,
              onClear: _clearAlarmSound,
            ),
            SwitchTile(
              title: l10n.settingsSoundEnabled,
              value: _soundEnabled,
              onChanged: (value) async {
                setState(() => _soundEnabled = value);
                await _settingsService.setSoundEnabled(value);
              },
              icon: LucideIcons.volume2,
            ),
            SwitchTile(
              title: l10n.settingsVibrate,
              value: _vibrateEnabled,
              onChanged: (value) async {
                setState(() => _vibrateEnabled = value);
                await _settingsService.setVibrationEnabled(value);
              },
              icon: LucideIcons.vibrate,
            ),
            const SizedBox(height: 24),

            // Security
            _buildSectionHeader(l10n.settingsSectionSecurity),
            CustomPinSection(
              title: l10n.settingsCustomPin,
              hintText: l10n.settingsEnterPinHint,
              enabled: _pinEnabled,
              pinController: _pinController,
              obscurePin: _pinObscured,
              onToggle: (value) async {
                setState(() => _pinEnabled = value);
                await _challengeService.setPinEnabled(_prefs, value);
              },
              onToggleObscure: () =>
                  setState(() => _pinObscured = !_pinObscured),
              onPinChanged: (value) async {
                await _challengeService.setPin(_prefs, value);
              },
            ),
            const SizedBox(height: 12),
            CustomPinSection(
              title: l10n.settingsDigitCode,
              hintText: l10n.settingsEnterDigitCodeHint,
              enabled: _digitCodeEnabled,
              pinController: _digitCodeController,
              obscurePin: _digitCodeObscured,
              onToggle: (value) async {
                setState(() => _digitCodeEnabled = value);
                await _challengeService.setDigitCodeEnabled(_prefs, value);
              },
              onToggleObscure: () =>
                  setState(() => _digitCodeObscured = !_digitCodeObscured),
              onPinChanged: (value) async {
                await _challengeService.setDigitCode(_prefs, value);
              },
            ),
            const SizedBox(height: 24),

            // Functions
            _buildSectionHeader(l10n.settingsSectionFunctions),
            SwitchTile(
              title: l10n.settingsLocationService,
              value: _locationEnabled,
              onChanged: (value) async {
                setState(() => _locationEnabled = value);
                await _settingsService.setLocationServiceEnabled(value);
              },
              icon: LucideIcons.mapPin,
            ),
            SwitchTile(
              title: l10n.settingsCameraAccess,
              value: _cameraEnabled,
              onChanged: (value) async {
                setState(() => _cameraEnabled = value);
                await _settingsService.setCameraAccessEnabled(value);
              },
              icon: LucideIcons.camera,
            ),
            SwitchTile(
              title: l10n.settingsMicrophoneAccess,
              value: _microphoneEnabled,
              onChanged: (value) async {
                setState(() => _microphoneEnabled = value);
                await _settingsService.setMicrophoneAccessEnabled(value);
              },
              icon: LucideIcons.mic,
            ),
            ActionTile(
              title: l10n.settingsSensorDiagnostics,
              subtitle: l10n.settingsSensorDiagnosticsSubtitle,
              icon: LucideIcons.activity,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SensorDashboardPage()),
              ),
            ),
            const SizedBox(height: 24),

            // Support
            _buildSectionHeader(l10n.settingsSectionSupport),
            ActionTile(
              title: l10n.settingsStarOnGithub,
              subtitle: l10n.settingsStarOnGithubSubtitle,
              icon: LucideIcons.github,
              onTap: () => _showGitHubDialog(),
            ),
            ActionTile(
              title: l10n.settingsReportIssue,
              subtitle: l10n.settingsReportIssueSubtitle,
              icon: LucideIcons.bug,
              onTap: () => _showReportDialog(),
            ),
            ActionTile(
              title: l10n.settingsHelpFaq,
              subtitle: l10n.settingsHelpFaqSubtitle,
              icon: LucideIcons.helpCircle,
              onTap: () => _showHelpDialog(),
            ),
            const SizedBox(height: 24),

            // About
            _buildSectionHeader(l10n.settingsSectionAbout),
            InfoTile(title: l10n.settingsVersion, value: _appVersion),
            InfoTile(title: l10n.settingsBuild, value: _buildNumber),
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settingsStarOnGithub),
        content: Text(l10n.settingsGithubDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.dialogLater, style: TextStyle(color: AppColors.secondaryText(dialogContext))),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await launchUrl(
                Uri.parse('https://github.com/mohaneddz/BRB'),
                mode: LaunchMode.externalApplication,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.dialogStarNow),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settingsReportIssue),
        content: Text(l10n.settingsReportDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.dialogCancel, style: TextStyle(color: AppColors.secondaryText(dialogContext))),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await launchUrl(
                Uri.parse('https://github.com/mohaneddz/BRB/issues/new'),
                mode: LaunchMode.externalApplication,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.dialogReport),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settingsHelpFaq),
        content: Text(l10n.settingsHelpDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.dialogCancel, style: TextStyle(color: AppColors.secondaryText(dialogContext))),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await launchUrl(
                Uri.parse('https://github.com/mohaneddz/BRB#readme'),
                mode: LaunchMode.externalApplication,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.dialogViewHelp),
          ),
        ],
      ),
    );
  }
}
