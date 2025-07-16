import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';

class CameraService {
  CameraController? controller;
  List<CameraDescription>? cameras;
  int selectedCameraIdx = 0;
  bool isSaving = false;

  Future<void> initCameras() async {
    cameras = await availableCameras();
    // Prefer front camera if available
    int frontIdx = cameras!.indexWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
    );
    selectedCameraIdx = frontIdx != -1 ? frontIdx : 0;
    if (cameras!.isNotEmpty) {
      await onNewCameraSelected(cameras![selectedCameraIdx], selectedCameraIdx);
    }
  }

  Future<void> switchCamera(Function(CameraController?, int) onUpdate) async {
    if (cameras == null || cameras!.length < 2) return;
    final newIdx = (selectedCameraIdx + 1) % cameras!.length;
    await onNewCameraSelected(cameras![newIdx], newIdx, onUpdate: onUpdate);
  }

  Future<void> onNewCameraSelected(
    CameraDescription cameraDescription,
    int newIdx, {
    Function(CameraController?, int)? onUpdate,
  }) async {
    final oldController = controller;
    controller = null;
    await oldController?.dispose();
    final newController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
    );
    try {
      await newController.initialize();
    } catch (e) {
      onUpdate?.call(null, selectedCameraIdx);
      return;
    }
    controller = newController;
    selectedCameraIdx = newIdx;
    onUpdate?.call(controller, selectedCameraIdx);
  }

  Future<void> takePicture(
    Function(bool) onSaving,
    BuildContext context,
  ) async {
    if (controller == null || !controller!.value.isInitialized) return;
    onSaving(true);
    final image = await controller!.takePicture();
    await GallerySaver.saveImage(image.path);
    onSaving(false);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Picture saved to gallery')));
    }
  }

  void dispose() {
    controller?.dispose();
  }
}
