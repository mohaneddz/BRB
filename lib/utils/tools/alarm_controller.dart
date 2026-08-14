import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import 'package:brb/models/history_event.dart';
import 'package:brb/pages/alarm.dart';
import 'package:brb/utils/settings_utis.dart';
import 'package:brb/utils/tools/camera_utils.dart';
import 'package:brb/utils/tools/gps_utils.dart';
import 'package:brb/utils/tools/history_service.dart';

/// Runs the side effects of a [DetectionService] trigger: vibrate, play an
/// alert sound, optionally snap a photo and grab a location fix, log the
/// event to history, and show the full-screen alarm.
class AlarmController {
  final HistoryService historyService;
  final GpsService gpsService;
  final SettingsService settingsService;

  AlarmController({
    required this.historyService,
    required this.gpsService,
    required this.settingsService,
  });

  Future<void> fire({
    required BuildContext context,
    required String mode,
    required bool vibrationEnabled,
    required bool soundEnabled,
    required bool cameraEnabled,
    required bool locationEnabled,
  }) async {
    if (vibrationEnabled) {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator == true) {
        Vibration.vibrate(pattern: [0, 600, 200, 600, 200, 600]);
      }
    }
    if (soundEnabled) {
      await _playAlarmSound();
    }

    final photoPath = cameraEnabled ? await _tryCapturePhoto() : null;

    double? lat;
    double? lng;
    String? placeName;
    if (locationEnabled) {
      try {
        final position = await gpsService.getCurrentPosition();
        lat = position.latitude;
        lng = position.longitude;
        placeName = await _tryReverseGeocode(lat, lng);
      } catch (_) {
        // Location unavailable (permission revoked mid-flight, no fix, etc.)
        // - the alarm still fires without coordinates.
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await historyService.addEvent(
      prefs,
      HistoryEvent(
        timestamp: DateTime.now(),
        mode: mode,
        latitude: lat,
        longitude: lng,
        photoPath: photoPath,
        placeName: placeName,
      ),
    );

    if (context.mounted) {
      await Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (_) => const AlarmScreen(),
          fullscreenDialog: true,
        ),
      );
    }
  }

  Future<void> _playAlarmSound() async {
    final customPath = settingsService.getAlarmTonePath();
    if (customPath != null && await File(customPath).exists()) {
      try {
        final player = AudioPlayer();
        await player.play(DeviceFileSource(customPath));
        return;
      } catch (_) {
        // Fall through to the system alert sound below.
      }
    }
    SystemSound.play(SystemSoundType.alert);
  }

  /// Best-effort reverse geocode - returns null on no network, no
  /// geocoder available on the device, or any other failure, in which
  /// case the event is still logged, just with raw coordinates only.
  Future<String?> _tryReverseGeocode(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isEmpty) return null;
      final place = placemarks.first;
      final parts = [
        place.street,
        place.locality,
        place.country,
      ].where((p) => p != null && p.isNotEmpty).toList();
      return parts.isEmpty ? null : parts.join(', ');
    } catch (_) {
      return null;
    }
  }

  Future<String?> _tryCapturePhoto() async {
    final cameraService = CameraService();
    try {
      await cameraService.initCameras();
      final controller = cameraService.controller;
      if (controller == null || !controller.value.isInitialized) return null;
      final image = await controller.takePicture();
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'alarm_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final saved = await File(image.path).copy('${appDir.path}/$fileName');
      return saved.path;
    } catch (_) {
      return null;
    } finally {
      cameraService.dispose();
    }
  }
}
