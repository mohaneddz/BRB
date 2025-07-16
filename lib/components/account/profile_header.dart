import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:brb/utils/tools/camera_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;

class ProfileHeader extends StatefulWidget {
  final String fullName;
  final String username;
  final String bio;
  final String joinDate;
  final VoidCallback? onImagePicker;

  const ProfileHeader({
    super.key,
    required this.fullName,
    required this.username,
    required this.bio,
    required this.joinDate,
    this.onImagePicker,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String? _imagePath;
  final CameraService _cameraService = CameraService();

  @override
  void initState() {
    super.initState();
    _loadImagePath();
  }

  Future<void> _loadImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('profile_image_path');
    });
  }

  Future<void> _saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', path);
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedImage = await File(
          picked.path,
        ).copy('${appDir.path}/$fileName');
        setState(() {
          _imagePath = savedImage.path;
        });
        await _saveImagePath(savedImage.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not pick image: $e')));
      }
    }
  }

  Future<void> _takePicture() async {
    await _cameraService.initCameras();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkBgLight,
          content: AspectRatio(
            aspectRatio: 1, // Square preview
            child:
                _cameraService.controller != null &&
                    _cameraService.controller!.value.isInitialized
                ? CameraPreview(_cameraService.controller!)
                : const Center(child: CircularProgressIndicator()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_cameraService.controller != null &&
                    _cameraService.controller!.value.isInitialized) {
                  final image = await _cameraService.controller!.takePicture();
                  // Flip the image horizontally if using front camera
                  final appDir = await getApplicationDocumentsDirectory();
                  final fileName =
                      'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
                  final savedPath = '${appDir.path}/$fileName';

                  File original = File(image.path);
                  final bytes = await original.readAsBytes();
                  img.Image? captured = img.decodeImage(bytes);
                  if (captured != null) {
                    // Flip horizontally for selfie
                    img.Image flipped = img.flipHorizontal(captured);
                    await File(savedPath).writeAsBytes(img.encodeJpg(flipped));
                    setState(() {
                      _imagePath = savedPath;
                    });
                    await _saveImagePath(savedPath);
                  }
                }
                if (mounted) Navigator.of(context).pop();
              },
              child: const Text('Capture'),
            ),
          ],
        );
      },
    );
  }

  void _onImagePicker() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkBgLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(LucideIcons.camera),
              title: const Text('Take a new picture'),
              onTap: () async {
                Navigator.of(context).pop();
                await _takePicture();
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.image),
              title: const Text('Import from gallery'),
              onTap: () async {
                Navigator.of(context).pop();
                await _pickImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.darkBgLight,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 3),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _imagePath != null
                        ? FileImage(File(_imagePath!))
                        : const AssetImage('assets/images/user.jpg')
                              as ImageProvider,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _onImagePicker,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.darkBgLight,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      LucideIcons.camera,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            widget.fullName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '@${widget.username}',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.bio,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(label: 'Joined', value: widget.joinDate),
              Container(
                height: 40,
                width: 1,
                color: Colors.grey.withAlpha((0.3 * 255).toInt()),
              ),
              const _StatItem(label: 'Status', value: 'Active'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
