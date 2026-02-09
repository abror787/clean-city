import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/report_data.dart';

class TakePhotoScreen extends StatefulWidget {
  const TakePhotoScreen({super.key});

  @override
  State<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _capturedImage;
  bool _isCapturing = false;

  Future<void> _takePhoto() async {
    if (_isCapturing) return;

    setState(() => _isCapturing = true);

    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (photo != null && mounted) {
        setState(() {
          _capturedImage = File(photo.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка камеры: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null && mounted) {
        setState(() {
          _capturedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка галереи: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _confirmAndProceed() {
    if (_capturedImage != null) {
      final reportData = ReportData(imageFile: _capturedImage);
      Navigator.pushNamed(
        context,
        AppRoutes.selectCategory,
        arguments: reportData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Image Preview or Camera Placeholder
            if (_capturedImage != null)
              Positioned.fill(
                child: Image.file(_capturedImage!, fit: BoxFit.contain),
              )
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 100,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Сделайте фото мусора',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

            // Header - Close button
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // Bottom Controls
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: _capturedImage != null
                  ? _buildConfirmControls()
                  : _buildCaptureControls(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaptureControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Gallery Button
        IconButton(
          icon: const Icon(Icons.photo_library, color: Colors.white, size: 32),
          onPressed: _pickFromGallery,
        ),
        const SizedBox(width: 40),

        // Capture Button
        GestureDetector(
          onTap: _takePhoto,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _isCapturing ? Colors.grey : Colors.white,
                shape: BoxShape.circle,
              ),
              child: _isCapturing
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(width: 72), // Balance the layout
      ],
    );
  }

  Widget _buildConfirmControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Retake Button
        TextButton.icon(
          onPressed: () {
            setState(() => _capturedImage = null);
          },
          icon: const Icon(Icons.refresh, color: Colors.white),
          label: const Text('Переснять', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 32),

        // Confirm Button
        ElevatedButton.icon(
          onPressed: _confirmAndProceed,
          icon: const Icon(Icons.check),
          label: const Text('Продолжить'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}
