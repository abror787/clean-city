import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_gradients.dart';
import '../../../core/constants/app_routes.dart';
import '../../bloc/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _animationComplete = false;

  @override
  void initState() {
    super.initState();
    _startAnimationTimer();
  }

  void _startAnimationTimer() async {
    // Wait for splash animation to complete
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _animationComplete = true;
      });
      // Check if we can navigate immediately
      _tryNavigate(context.read<AuthBloc>().state);
    }
  }

  void _tryNavigate(AuthState state) {
    if (!_animationComplete || !mounted) return;

    // Don't navigate while still loading or unknown
    if (state.status == AuthStatus.unknown ||
        state.status == AuthStatus.loading) {
      return;
    }

    if (state.status == AuthStatus.authenticated && state.role != null) {
      if (state.role == 'driver') {
        Navigator.pushReplacementNamed(context, AppRoutes.driverDashboard);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.residentDashboard);
      }
    } else {
      // Unauthenticated or error - go to role selection
      Navigator.pushReplacementNamed(context, AppRoutes.roleSelection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // When auth state changes and animation is complete, navigate
        _tryNavigate(state);
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: AppGradients.resident),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with animation
                Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.eco,
                        size: 80,
                        color: AppColors.primary,
                      ),
                    )
                    .animate()
                    .scale(duration: 600.ms, curve: Curves.easeOutBack)
                    .then()
                    .shimmer(
                      duration: 1200.ms,
                      color: Colors.white.withOpacity(0.5),
                    ),

                const SizedBox(height: 32),

                // App Name
                Text(
                  'Clean City',
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),

                const SizedBox(height: 12),

                // Tagline
                Text(
                  'Управление городскими отходами',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
