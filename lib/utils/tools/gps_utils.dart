import 'package:geolocator/geolocator.dart';
import 'dart:async';

class GpsService {
  void Function()? onUpdate;
  final LocationSettings locationSettings;
  Timer? locationTimer;
  Position? initialPosition;
  double? maxDistanceFromStart;
  Position? lastPosition;

  GpsService({
    this.onUpdate,
    this.locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    ),
  });

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  Future<void> setInitialPosition({void Function()? onUpdate}) async {
    if (onUpdate != null) this.onUpdate = onUpdate;
    initialPosition = await getCurrentPosition();
    maxDistanceFromStart = 0.0;
    lastPosition = initialPosition;
    this.onUpdate?.call();
    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    locationTimer?.cancel();
    locationTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      try {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings,
        );
        lastPosition = position;
        if (initialPosition != null) {
          double distance = Geolocator.distanceBetween(
            initialPosition!.latitude,
            initialPosition!.longitude,
            position.latitude,
            position.longitude,
          );
          if (maxDistanceFromStart == null ||
              distance > maxDistanceFromStart!) {
            maxDistanceFromStart = distance;
          }
        }
        onUpdate?.call();
      } catch (_) {}
    });
  }

  double? calculateDistance(Position position) {
    if (initialPosition == null) return null;
    double distance = Geolocator.distanceBetween(
      initialPosition!.latitude,
      initialPosition!.longitude,
      position.latitude,
      position.longitude,
    );
    if (maxDistanceFromStart == null || distance > maxDistanceFromStart!) {
      maxDistanceFromStart = distance;
    }
    return distance;
  }

  void dispose() {
    locationTimer?.cancel();
  }
}
