class AppRoutes {
  static const splash = '/'; // Splash is initial route
  static const onboarding = '/onboarding';
  
  // Auth
  static const residentLogin = '/resident-login';
  static const residentRegistration = '/resident-registration';
  static const driverLogin = '/driver-login';
  static const driverRegistration = '/driver-registration';
  static const otpVerification = '/otp-verification';
  static const roleSelection = '/role-selection';
  static const emailLogin = '/email-login';
  static const passwordEntry = '/password-entry';
  
  // Resident
  static const residentDashboard = '/resident-dashboard';
  static const takePhoto = '/take-photo';
  static const selectCategory = '/select-category';
  static const confirmLocation = '/confirm-location';
  static const additionalDetails = '/additional-details';
  static const reportSuccess = '/report-success';
  static const cityMap = '/city-map';
  static const reportDetails = '/report-details';
  static const residentHistory = '/resident-history';
  static const residentProfile = '/resident-profile';
  static const residentSettings = '/resident-settings';
  
  // Driver
  static const driverDashboard = '/driver-dashboard';
  static const taskDetails = '/task-details';
  static const proofPhoto = '/proof-photo';
  static const driverTaskHistory = '/driver-task-history';
  static const driverProfile = '/driver-profile';
  static const driverSettings = '/driver-settings';
  
  // Shared
  static const editProfile = '/edit-profile';
}
