import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';

class TakePhotoScreen extends StatefulWidget {
  const TakePhotoScreen({super.key});

  @override
  State<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  // Placeholder for camera controller
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview Placeholder
            const Center(
              child: Icon(Icons.camera_alt, size: 100, color: Colors.white54),
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
                    // Simulate photo capture
                    Navigator.pushNamed(context, AppRoutes.selectCategory);
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
            
            // Gallery Button
            Positioned(
              bottom: 60,
              left: 40,
              child: IconButton(
                icon: const Icon(Icons.photo_library, color: Colors.white, size: 32),
                onPressed: () {
                  // Open gallery
                  Navigator.pushNamed(context, AppRoutes.selectCategory);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
