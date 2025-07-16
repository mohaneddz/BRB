// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Sensors :
import 'package:brb/utils/tools/gps_utils.dart';
import 'package:brb/utils/tools/steps_utils.dart';
import 'package:brb/utils/tools/sensors_utils.dart';
import 'package:brb/utils/tools/proximity_utils.dart';
import 'package:brb/utils/tools/camera_utils.dart';
import 'package:camera/camera.dart';

// --- SENSOR DASHBOARD PAGE ---
class SensorDashboardPage extends StatefulWidget {
  const SensorDashboardPage({super.key});

  @override
  State<SensorDashboardPage> createState() => _SensorDashboardPageState();
}

class _SensorDashboardPageState extends State<SensorDashboardPage> {
  late final GpsService gpsService;
  late final StepsService stepsService;
  late final SensorsService sensorsService;
  late final ProximityService proximityService;
  late final CameraService cameraService;
  String locationPermissionStatus = 'Checking...';

  @override
  void initState() {
    super.initState();
    
    gpsService = GpsService(onUpdate: () => setState(() {}));
    stepsService = StepsService(onUpdate: () => setState(() {}));
    sensorsService = SensorsService(onUpdate: () => setState(() {}));
    proximityService = ProximityService(onUpdate: () => setState(() {}));

    cameraService = CameraService();
    // GPS
    gpsService.setInitialPosition();
    // Steps
    stepsService.start();
    // Sensors
    sensorsService.start();
    // Proximity
    proximityService.start();
    // Camera: initialized on demand in the UI
  }

  void setLocation() async {
    await gpsService.setInitialPosition();
    setState(() {});
  }

  void _resetSteps() {
    setState(() {
      stepsService.resetSteps();
    });
  }

  String get durationSinceLastStepUpdate {
    if (stepsService.lastStepUpdate == null) return 'Never';
    final diff = DateTime.now().difference(stepsService.lastStepUpdate!);
    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else {
      return '${diff.inHours}h ago';
    }
  }

  @override
  void dispose() {
    sensorsService.dispose();
    proximityService.dispose();
    cameraService.dispose();
    super.dispose();
  }

  String formatSensor(List<double>? values) {
    if (values == null) return 'N/A';
    return values.map((v) => v.toStringAsFixed(2)).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sensor Dashboard'), actions: []),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          _SensorCard(
            title: 'GPS',
            icon: LucideIcons.mapPin,
            data: {
              'Initial Latitude':
                  gpsService.initialPosition?.latitude.toString() ?? 'N/A',
              'Initial Longitude':
                  gpsService.initialPosition?.longitude.toString() ?? 'N/A',
              'Latitude':
                  gpsService.initialPosition?.latitude.toString() ?? 'N/A',
              'Longitude':
                  gpsService.initialPosition?.longitude.toString() ?? 'N/A',
              'Distance from Start (m)':
                  gpsService.maxDistanceFromStart?.toStringAsFixed(2) ?? 'N/A',
              'Maximum Distance (m)':
                  gpsService.maxDistanceFromStart?.toStringAsFixed(2) ?? 'N/A',
              'Status': locationPermissionStatus,
            },
            onPressed: () {
              setLocation();
            },
            buttonText: 'Set Initial',
          ),
          _SensorCard(
            title: 'Steps',
            icon: LucideIcons.activity,
            data: {
              'Current Steps': stepsService.steps,
              'Status': stepsService.status,
              'Last Step Update': durationSinceLastStepUpdate,
            },
            onPressed: _resetSteps,
            buttonText: 'Reset Steps',
          ),
          _SensorCard(
            title: 'Sensors',
            icon: LucideIcons.cpu,
            data: {
              'Accelerometer': formatSensor(sensorsService.accelerometerValues),
              'User Accelerometer': formatSensor(
                sensorsService.userAccelerometerValues,
              ),
              'Gyroscope': formatSensor(sensorsService.gyroscopeValues),
              'Magnetometer': formatSensor(sensorsService.magnetometerValues),
            },
            buttonText: 'Refresh',
            onPressed: () {},
          ),
          _SensorCard(
            title: 'Proximity',
            icon: LucideIcons.eye,
            data: {'Is Near': proximityService.isNear ? 'Yes' : 'No'},
            buttonText: 'Info',
            onPressed: () {},
          ),
          const SizedBox(height: 24),
          const Text(
            'Camera',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const CameraWidget(),
        ],
      ),
    );
  }
}

class _SensorCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Map<String, String> data;
  final void Function()? onPressed;
  final String? buttonText;
  const _SensorCard({
    required this.title,
    required this.icon,
    required this.data,
    this.onPressed,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Icon + Title
            Row(
              children: [
                Icon(icon, size: 40),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Middle row: Data
            ...data.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  '${entry.key}: ${entry.value}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            // Bottom right: Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(LucideIcons.info),
                  label: Text(buttonText ?? 'More Info'),
                  onPressed: onPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CameraWidget extends StatelessWidget {
  const CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.camera_alt),
      label: const Text('Open Camera'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FullScreenCameraPage()),
        );
      },
    );
  }
}

class FullScreenCameraPage extends StatefulWidget {
  const FullScreenCameraPage({super.key});

  @override
  State<FullScreenCameraPage> createState() => _FullScreenCameraPageState();
}

class _FullScreenCameraPageState extends State<FullScreenCameraPage> {
  final cameraService = CameraService();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    cameraService.initCameras().then((_) {
      setState(() {});
    });
  }

  void _switchCamera() async {
    await cameraService.switchCamera((controller, idx) {
      setState(() {});
    });
  }

  void _takePicture() async {
    await cameraService.takePicture((saving) {
      setState(() {
        _isSaving = saving;
      });
    }, context);
  }

  @override
  void dispose() {
    cameraService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = cameraService.controller;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: _switchCamera,
            tooltip: 'Switch Camera',
          ),
        ],
      ),
      body: controller == null || !controller.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned.fill(child: CameraPreview(controller)),
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton.icon(
                      icon: _isSaving
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.camera),
                      label: const Text('Take Picture'),
                      onPressed: _isSaving ? null : _takePicture,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
