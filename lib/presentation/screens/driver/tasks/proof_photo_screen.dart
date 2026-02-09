import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';

class ProofPhotoScreen extends StatefulWidget {
  const ProofPhotoScreen({super.key});

  @override
  State<ProofPhotoScreen> createState() => _ProofPhotoScreenState();
}

class _ProofPhotoScreenState extends State<ProofPhotoScreen> {
  // Placeholder for camera controller/image
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview Placeholder
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 100, color: Colors.white54),
                  SizedBox(height: 16),
                  Text('Сфотографируйте убранную территорию', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            
            // Header
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            
            // Capture Button
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Simulate processing and success
                    _showSuccessDialog();
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.check_circle, color: AppColors.success, size: 64),
          title: const Text('Задание выполнено!'),
          content: const Text(
            'Отличная работа! Фотография отправлена на проверку.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                 Navigator.pushNamedAndRemoveUntil(
                  context, 
                  AppRoutes.driverDashboard, 
                  (route) => false
                );
              },
              child: const Text('К списку заданий'),
            ),
          ],
        );
      },
    );
  }
}
