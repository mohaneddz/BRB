import 'package:proximity_sensor/proximity_sensor.dart';
import 'dart:async';

class ProximityService {
  void Function()? onUpdate;
  bool isNear = false;
  StreamSubscription<dynamic>? proximitySub;

  ProximityService({this.onUpdate});

  void start() {
    proximitySub = ProximitySensor.events.listen((int event) {
      isNear = (event > 0);
      onUpdate?.call();
    });
  }

  void dispose() {
    proximitySub?.cancel();
  }
}
