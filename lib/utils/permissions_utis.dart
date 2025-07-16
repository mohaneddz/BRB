import 'package:permission_handler/permission_handler.dart';

class PermissionsService {

  // === CAMERA ===
  Future<bool> hasCamera() async => await Permission.camera.isGranted;

  Future<bool> requestCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  // === MICROPHONE ===
  Future<bool> hasMic() async => await Permission.microphone.isGranted;

  Future<bool> requestMic() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  // === LOCATION ===
  Future<bool> hasLocation() async => await Permission.locationWhenInUse.isGranted;

  Future<bool> requestLocation() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  // === STORAGE (Android) ===
  Future<bool> hasStorage() async => await Permission.storage.isGranted;

  Future<bool> requestStorage() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  // === NOTIFICATIONS ===
  Future<bool> hasNotifications() async => await Permission.notification.isGranted;

  Future<bool> requestNotifications() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  // === CONTACTS ===
  Future<bool> hasContacts() async => await Permission.contacts.isGranted;

  Future<bool> requestContacts() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  // === SENSORS ===
  Future<bool> hasSensors() async => await Permission.sensors.isGranted;

  Future<bool> requestSensors() async {
    final status = await Permission.sensors.request();
    return status.isGranted;
  }

  // === OPEN SETTINGS ===
  Future<void> openSettings() async {
    await openAppSettings();
  }
}
