import 'package:flutter/material.dart';

import 'package:brb/styles/style.dart';
import 'package:brb/components/home/main_button.dart';
import 'package:brb/components/home/configuration_card.dart';
import 'package:brb/models/config_values.dart';
import 'package:brb/pages/presets.dart';
import 'package:brb/utils/settings_utis.dart';
import 'package:brb/utils/permissions_utis.dart';
import 'package:brb/utils/tools/alarm_controller.dart';
import 'package:brb/utils/tools/detection_service.dart';
import 'package:brb/utils/tools/gps_utils.dart';
import 'package:brb/utils/tools/history_service.dart';
import 'package:brb/utils/tools/notification_service.dart';
import 'package:brb/utils/tools/proximity_utils.dart';
import 'package:brb/utils/tools/sensors_utils.dart';
import 'package:brb/utils/tools/steps_utils.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SettingsService _settingsService = SettingsService();
  final PermissionsService _permissionsService = PermissionsService();
  final HistoryService _historyService = HistoryService();
  final NotificationService _notificationService = NotificationService();

  final SensorsService _sensorsService = SensorsService();
  final ProximityService _proximityService = ProximityService();
  final GpsService _gpsService = GpsService();
  final StepsService _stepsService = StepsService();
  late final DetectionService _detectionService;
  late final AlarmController _alarmController;

  final GlobalKey<ConfigurationCardState> _configKey =
      GlobalKey<ConfigurationCardState>();

  bool _armed = false;
  bool _loading = true;
  ConfigValues _config = ConfigValues.defaults;

  @override
  void initState() {
    super.initState();
    _detectionService = DetectionService(
      sensorsService: _sensorsService,
      proximityService: _proximityService,
      gpsService: _gpsService,
      stepsService: _stepsService,
    );
    _alarmController = AlarmController(
      historyService: _historyService,
      gpsService: _gpsService,
      settingsService: _settingsService,
    );
    _detectionService.onTrigger = _onTriggered;
    _init();
  }

  Future<void> _init() async {
    await _settingsService.init();
    setState(() {
      _config = ConfigValues(
        mode: _settingsService.getActiveMode(),
        delay: _settingsService.getActiveDelay(),
        grace: _settingsService.getActiveGrace(),
        camera: _settingsService.getActiveCameraEnabled(),
        location: _settingsService.getActiveLocationEnabled(),
        mic: _settingsService.getActiveMicEnabled(),
        sound: _settingsService.getActiveSound(),
        vibration: _settingsService.getActiveVibrationConfig(),
        challengeType: _settingsService.getActiveChallengeType(),
      );
      _loading = false;
    });
  }

  Future<void> _onConfigChanged(ConfigValues values) async {
    _config = values;
    await _settingsService.setActiveMode(values.mode);
    await _settingsService.setActiveDelay(values.delay);
    await _settingsService.setActiveGrace(values.grace);
    await _settingsService.setActiveCameraEnabled(values.camera);
    await _settingsService.setActiveLocationEnabled(values.location);
    await _settingsService.setActiveMicEnabled(values.mic);
    await _settingsService.setActiveSound(values.sound);
    await _settingsService.setActiveVibrationConfig(values.vibration);
    await _settingsService.setActiveChallengeType(values.challengeType);
  }

  Future<void> _openPresets() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const Presets()));
    if (!mounted) return;
    // A preset may have been applied while we were away - reload and push
    // the fresh values into the (still-mounted) ConfigurationCard.
    final reloaded = ConfigValues(
      mode: _settingsService.getActiveMode(),
      delay: _settingsService.getActiveDelay(),
      grace: _settingsService.getActiveGrace(),
      camera: _settingsService.getActiveCameraEnabled(),
      location: _settingsService.getActiveLocationEnabled(),
      mic: _settingsService.getActiveMicEnabled(),
      sound: _settingsService.getActiveSound(),
      vibration: _settingsService.getActiveVibrationConfig(),
      challengeType: _settingsService.getActiveChallengeType(),
    );
    _config = reloaded;
    _configKey.currentState?.applyValues(reloaded);
  }

  Future<bool> _requestPermissions() async {
    if (!await _permissionsService.hasSensors()) {
      await _permissionsService.requestSensors();
    }
    final cameraWanted = _config.camera && _settingsService.isCameraAccessEnabled();
    final locationWanted =
        _config.location && _settingsService.isLocationServiceEnabled();
    final micWanted = _config.mic && _settingsService.isMicrophoneAccessEnabled();
    if (cameraWanted && !await _permissionsService.hasCamera()) {
      if (!await _permissionsService.requestCamera()) return false;
    }
    if (locationWanted && !await _permissionsService.hasLocation()) {
      if (!await _permissionsService.requestLocation()) return false;
    }
    if (micWanted && !await _permissionsService.hasMic()) {
      if (!await _permissionsService.requestMic()) return false;
    }
    return true;
  }

  Future<void> _toggleArmed() async {
    if (_armed) {
      _detectionService.disarm();
      await _notificationService.cancelArmed();
      setState(() => _armed = false);
      return;
    }

    final granted = await _requestPermissions();
    if (!granted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'BRB needs the permissions for the options you enabled '
              '(camera/location/microphone) to arm with them.',
            ),
          ),
        );
      }
      return;
    }

    await _detectionService.arm(
      mode: detectionModeFromLabel(_config.mode),
      sensitivity: _settingsService.getMotionSensitivity(),
      detectionDelaySeconds: _config.delay.round().clamp(1, 999),
      distanceThresholdMeters:
          _config.grace * _settingsService.getMaxDistanceMeters(),
      stepsThreshold: _settingsService.getStepsThreshold(),
    );
    if (!mounted) return;
    setState(() => _armed = true);

    if (_settingsService.getFloatingNotifications()) {
      if (!await _permissionsService.hasNotifications()) {
        await _permissionsService.requestNotifications();
      }
      if (await _permissionsService.hasNotifications()) {
        await _notificationService.showArmed(_config.mode);
      }
    }
  }

  Future<void> _onTriggered() async {
    if (!mounted) return;
    setState(() => _armed = false);
    await _notificationService.cancelArmed();
    if (!mounted) return;
    await _alarmController.fire(
      context: context,
      mode: _config.mode,
      vibrationEnabled: _config.vibration,
      soundEnabled: _settingsService.isSoundEnabled(),
      cameraEnabled: _config.camera && _settingsService.isCameraAccessEnabled(),
      locationEnabled:
          _config.location && _settingsService.isLocationServiceEnabled(),
      micEnabled: _config.mic && _settingsService.isMicrophoneAccessEnabled(),
      challengeType: _config.challengeType,
    );
  }

  @override
  void dispose() {
    _detectionService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 0.0,
                ),
                child: Column(
                  children: [
                    LooperButton(
                      text: _armed ? 'ON!' : 'OFF!',
                      onClick: _toggleArmed,
                    ),
                    ConfigurationCard(
                      key: _configKey,
                      initialValues: _config,
                      onChanged: _onConfigChanged,
                      onOpenPresets: _openPresets,
                      locked: _armed,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
