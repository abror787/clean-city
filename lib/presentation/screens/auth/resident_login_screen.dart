import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';

class ResidentLoginScreen extends StatelessWidget {
  const ResidentLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: This replaces the old phone-based login screen.
    // It is now a unified login screen, but we keep the file name for now to avoid breaking too many imports.
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // Logo or Illustration
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    size: 64,
                    color: AppColors.primary,
                  ),
                ),
              ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
              
              const SizedBox(height: 32),
              
              Text(
                'Добро пожаловать',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn().slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 12),
              
              Text(
                'Войдите через социальные сети для продолжения',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
              
              const Spacer(),
              
              // Google Login
              _socialLoginButton(
                icon: 'assets/google_logo.png', // Placeholder for asset
                label: 'Продолжить с Google',
                color: Colors.white,
                textColor: Colors.black,
                borderColor: AppColors.border,
                iconColor: Colors.red, // Temp icon color since we don't have asset
                onPressed: () {
                  // Simulate login success -> Go to Role Selection or Dashboard directly if role known
                  // For now, let's assume successful login goes to Role Selection (or Dashboard if flow is different)
                  // User wanted: "when it comes to sign up or login i dont feel difference... make it clear"
                  
                  // If we treat this as "Sign In", checking role would happen here.
                  // Since we are simplifying, let's just go to Dashboard for demo purposes, 
                  // or back to Role Selection if this screen was reached FROM Role Selection?
                  
                  // Wait, flow is: Onboarding -> Role Selection -> Login (if needed) -> Dashboard.
                  // Or: Onboarding -> Login -> Role Selection -> Dashboard.
                  
                  // The user said: "make it clear too in obvious way just do it".
                  // Role Selection handles the clarity.
                  // IF they click "Resident" on Role Selection -> Check Clean City Server -> If token valid, go Dashboard. Else -> Show Login.
                  
                  // So this screen is shown if they are NOT logged in.
                  // After login, we need to know what role they selected.
                  // For simplicity in UI demo:
                  Navigator.pushReplacementNamed(context, AppRoutes.residentDashboard);
                },
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.5, end: 0),
              
              const SizedBox(height: 16),
              
              // Apple Login
              _socialLoginButton(
                icon: 'assets/apple_logo.png',
                label: 'Продолжить с Apple',
                color: Colors.black,
                textColor: Colors.white,
                borderColor: Colors.black,
                iconColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.residentDashboard);
                },
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.5, end: 0),
              
               const SizedBox(height: 32),
               
               Text(
                'Продолжая, вы соглашаетесь с Условиями использования и Политикой конфиденциальности',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 800.ms),
               
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton({
    required String icon,
    required String label,
    required Color color,
    required Color textColor,
    required Color borderColor,
    required Color iconColor, // Temp
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Temporary Icon replacement
            Icon(Icons.login, color: iconColor), 
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
