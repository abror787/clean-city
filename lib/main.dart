import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_routes.dart';
import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/profile/profile_bloc.dart';
import 'presentation/bloc/waste_event/waste_event_bloc.dart';
import 'presentation/bloc/driver/driver_task_bloc.dart';
import 'presentation/screens/auth/driver_login_screen.dart';
import 'presentation/screens/auth/driver_registration_screen.dart';
import 'presentation/screens/auth/email_login_screen.dart';
import 'presentation/screens/auth/otp_verification_screen.dart';
import 'presentation/screens/auth/password_entry_screen.dart';
import 'presentation/screens/auth/resident_login_screen.dart'; // Keeping old import for now or delete?
import 'presentation/screens/auth/resident_registration_screen.dart';
import 'presentation/screens/auth/role_selection_screen.dart';
import 'presentation/screens/driver/profile/driver_settings_screen.dart';
import 'presentation/screens/driver/tasks/proof_photo_screen.dart';
import 'presentation/screens/driver/dashboard/driver_dashboard_screen.dart';
import 'presentation/screens/driver/tasks/task_details_screen.dart';
import 'presentation/screens/onboarding/onboarding_screen.dart';
import 'presentation/screens/profile/edit_profile_screen.dart';
import 'presentation/screens/resident/dashboard/resident_dashboard_screen.dart';
import 'presentation/screens/resident/map/report_details_screen.dart';
import 'presentation/screens/resident/profile/resident_settings_screen.dart';
import 'presentation/screens/resident/report/additional_details_screen.dart';
import 'presentation/screens/resident/report/confirm_location_screen.dart';
import 'presentation/screens/resident/report/report_success_screen.dart';
import 'presentation/screens/resident/report/select_category_screen.dart';
import 'presentation/screens/resident/report/take_photo_screen.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ru'), Locale('en'), Locale('uz')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      child: const CleanCityApp(),
    ),
  );
}

class CleanCityApp extends StatelessWidget {
  const CleanCityApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()..add(AuthCheckStatus()),
        ),
        BlocProvider<ProfileBloc>(create: (_) => di.sl<ProfileBloc>()),
        BlocProvider<WasteEventBloc>(create: (_) => di.sl<WasteEventBloc>()),
        BlocProvider<DriverTaskBloc>(create: (_) => di.sl<DriverTaskBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated && state.role != null) {
            final nav = CleanCityApp.navigatorKey.currentState;
            if (nav != null) {
              if (state.role == 'resident') {
                nav.pushNamedAndRemoveUntil(
                  AppRoutes.residentDashboard,
                  (route) => false,
                );
              } else if (state.role == 'driver') {
                nav.pushNamedAndRemoveUntil(
                  AppRoutes.driverDashboard,
                  (route) => false,
                );
              }
            }
          } else if (state.status == AuthStatus.unauthenticated) {
            final nav = CleanCityApp.navigatorKey.currentState;
            nav?.pushNamedAndRemoveUntil(
              AppRoutes.roleSelection,
              (route) => false,
            );
          }
        },
        child: MaterialApp(
          navigatorKey: CleanCityApp.navigatorKey,
          title: 'Clean City',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          routes: {
            AppRoutes.splash: (context) => const SplashScreen(),
            AppRoutes.onboarding: (context) => const OnboardingScreen(),
            AppRoutes.residentLogin: (context) => const ResidentLoginScreen(),
            AppRoutes.residentRegistration: (context) =>
                const ResidentRegistrationScreen(),
            AppRoutes.otpVerification: (context) =>
                const OTPVerificationScreen(),
            AppRoutes.residentDashboard: (context) =>
                const ResidentDashboardScreen(),
            AppRoutes.takePhoto: (context) => const TakePhotoScreen(),
            AppRoutes.selectCategory: (context) => const SelectCategoryScreen(),
            AppRoutes.confirmLocation: (context) =>
                const ConfirmLocationScreen(),
            AppRoutes.additionalDetails: (context) =>
                const AdditionalDetailsScreen(),
            AppRoutes.reportSuccess: (context) => const ReportSuccessScreen(),
            AppRoutes.reportDetails: (context) => const ReportDetailsScreen(),
            AppRoutes.residentSettings: (context) =>
                const ResidentSettingsScreen(),
            AppRoutes.driverLogin: (context) => const DriverLoginScreen(),
            AppRoutes.driverRegistration: (context) =>
                const DriverRegistrationScreen(),
            AppRoutes.driverDashboard: (context) =>
                const DriverDashboardScreen(),
            AppRoutes.taskDetails: (context) => const TaskDetailsScreen(),
            AppRoutes.proofPhoto: (context) => const ProofPhotoScreen(),
            AppRoutes.roleSelection: (context) => const RoleSelectionScreen(),
            AppRoutes.driverSettings: (context) => const DriverSettingsScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == AppRoutes.editProfile) {
              return MaterialPageRoute(
                builder: (context) => const EditProfileScreen(),
              );
            }
            if (settings.name == AppRoutes.emailLogin) {
              final role = settings.arguments as String;
              return MaterialPageRoute(
                builder: (context) => EmailLoginScreen(role: role),
              );
            }
            if (settings.name == AppRoutes.passwordEntry) {
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => PasswordEntryScreen(
                  email: args['email'],
                  role: args['role'],
                ),
              );
            }
            return null; // Let standard routes handle it
          },
        ),
      ),
    );
  }
}
