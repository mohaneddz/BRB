import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class SensorsService {
  void Function()? onUpdate;
  List<double>? accelerometerValues;
  List<double>? userAccelerometerValues;
  List<double>? gyroscopeValues;
  List<double>? magnetometerValues;

  StreamSubscription? accelerometerSub;
  StreamSubscription? userAccelerometerSub;
  StreamSubscription? gyroscopeSub;
  StreamSubscription? magnetometerSub;

  SensorsService({this.onUpdate});

  void start() {
    accelerometerSub = accelerometerEvents.listen((event) {
      accelerometerValues = [event.x, event.y, event.z];
      onUpdate?.call();
    });
    userAccelerometerSub = userAccelerometerEvents.listen((event) {
      userAccelerometerValues = [event.x, event.y, event.z];
      onUpdate?.call();
    });
    gyroscopeSub = gyroscopeEvents.listen((event) {
      gyroscopeValues = [event.x, event.y, event.z];
      onUpdate?.call();
    });
    magnetometerSub = magnetometerEvents.listen((event) {
      magnetometerValues = [event.x, event.y, event.z];
      onUpdate?.call();
    });
  }

  void dispose() {
    accelerometerSub?.cancel();
    userAccelerometerSub?.cancel();
    gyroscopeSub?.cancel();
    magnetometerSub?.cancel();
  }
}
