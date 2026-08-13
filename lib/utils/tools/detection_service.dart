import 'dart:async';
import 'dart:math';

import 'package:brb/utils/tools/gps_utils.dart';
import 'package:brb/utils/tools/proximity_utils.dart';
import 'package:brb/utils/tools/sensors_utils.dart';
import 'package:brb/utils/tools/steps_utils.dart';

enum DetectionMode { pocket, sensitive, distant, steps }

DetectionMode detectionModeFromLabel(String label) {
  switch (label) {
    case 'Sensitive':
      return DetectionMode.sensitive;
    case 'Distant':
      return DetectionMode.distant;
    case 'Steps':
      return DetectionMode.steps;
    case 'Pocket':
    default:
      return DetectionMode.pocket;
  }
}

/// Watches the phone's sensors while armed and calls [onTrigger] once it
/// decides the phone has been picked up / moved away.
///
/// There's no ground-truth "pickup" signal on a phone, so this is a
/// heuristic, not a certainty:
/// - [DetectionMode.pocket]: fires on sudden motion OR on the proximity
///   sensor going from "covered" (in a pocket/bag) to "uncovered".
/// - [DetectionMode.sensitive]: same motion check as pocket mode, but with
///   a much lower threshold.
/// - [DetectionMode.distant]: fires once GPS distance from the arm point
///   exceeds [distanceThresholdMeters].
/// - [DetectionMode.steps]: fires once the step counter advances past
///   [stepsThreshold] steps since arming.
///
/// A reading only counts once it stays past its threshold continuously for
/// [detectionDelaySeconds] - a single spike (bumping a table) shouldn't
/// trigger the alarm.
class DetectionService {
  final SensorsService sensorsService;
  final ProximityService proximityService;
  final GpsService gpsService;
  final StepsService stepsService;

  void Function()? onTrigger;

  bool armed = false;
  DetectionMode _mode = DetectionMode.pocket;
  double _sensitivity = 0.5;
  int _detectionDelaySeconds = 3;
  double _distanceThresholdMeters = 2.0;
  static const _stepsThreshold = 3;

  DateTime? _overThresholdSince;
  bool? _lastNear;
  bool _fired = false;

  DetectionService({
    required this.sensorsService,
    required this.proximityService,
    required this.gpsService,
    required this.stepsService,
  });

  Future<void> arm({
    required DetectionMode mode,
    required double sensitivity,
    required int detectionDelaySeconds,
    required double distanceThresholdMeters,
  }) async {
    _mode = mode;
    _sensitivity = sensitivity.clamp(0.0, 1.0);
    _detectionDelaySeconds = detectionDelaySeconds;
    _distanceThresholdMeters = distanceThresholdMeters;
    _overThresholdSince = null;
    _lastNear = null;
    _fired = false;

    sensorsService.onUpdate = _evaluate;
    proximityService.onUpdate = _evaluate;
    gpsService.onUpdate = _evaluate;
    stepsService.onUpdate = _evaluate;

    sensorsService.start();
    proximityService.start();
    if (mode == DetectionMode.distant) {
      await gpsService.setInitialPosition();
    }
    if (mode == DetectionMode.steps) {
      stepsService.start();
    }

    armed = true;
  }

  void disarm() {
    armed = false;
    _overThresholdSince = null;
    sensorsService.dispose();
    proximityService.dispose();
    gpsService.dispose();
    stepsService.dispose();
  }

  void _evaluate() {
    if (!armed || _fired) return;

    final overThreshold = switch (_mode) {
      DetectionMode.pocket => _motionOverThreshold() || _pocketOpened(),
      DetectionMode.sensitive => _motionOverThreshold(sensitiveMode: true),
      DetectionMode.distant => (gpsService.maxDistanceFromStart ?? 0) >
          _distanceThresholdMeters,
      DetectionMode.steps =>
        (int.tryParse(stepsService.steps) ?? 0) >= _stepsThreshold,
    };

    if (overThreshold) {
      _overThresholdSince ??= DateTime.now();
      final elapsed = DateTime.now().difference(_overThresholdSince!);
      if (elapsed.inMilliseconds >= _detectionDelaySeconds * 1000) {
        _fired = true;
        onTrigger?.call();
      }
    } else {
      _overThresholdSince = null;
    }
  }

  /// Magnitude of linear acceleration (gravity removed) vs. a threshold
  /// derived from sensitivity: sensitivity 1.0 -> low threshold (trips
  /// easily), sensitivity 0.0 -> high threshold (needs a hard knock).
  bool _motionOverThreshold({bool sensitiveMode = false}) {
    final values = sensorsService.userAccelerometerValues;
    if (values == null) return false;
    final magnitude = sqrt(
      values[0] * values[0] + values[1] * values[1] + values[2] * values[2],
    );
    final maxThreshold = sensitiveMode ? 3.0 : 8.0;
    const minThreshold = 0.8;
    final threshold =
        maxThreshold - (_sensitivity * (maxThreshold - minThreshold));
    return magnitude > threshold;
  }

  bool _pocketOpened() {
    final near = proximityService.isNear;
    final opened = _lastNear == true && near == false;
    _lastNear = near;
    return opened;
  }

  void dispose() {
    disarm();
  }
}
