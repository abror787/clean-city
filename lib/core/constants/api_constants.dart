class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://urban-waste-manager-production.up.railway.app';
  
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  
  // Waste Events (Resident)
  static const String wasteEvents = '/api/waste-events';
  static const String myWasteEvents = '/api/waste-events/my';
  static const String wasteEventById = '/api/waste-events/'; // + id
  
  // Media
  static const String mediaUpload = '/api/media';
  static const String mediaContent = '/api/media/'; // + token/content
  
  // User
  static const String users = '/api/users/'; // + id
  
  // Driver
  static const String driverTasks = '/driver/tasks';
  static const String driverTaskById = '/driver/tasks/'; // + id
  static const String driverTaskAccept = '/accept'; // suffix
  static const String driverTaskComplete = '/complete'; // suffix
  static const String driverTaskFail = '/fail'; // suffix
  
  // Admin (Optional, if we add admin features later)
  static const String adminAssign = '/admin/events/'; // + id/assign
  static const String adminVerify = '/admin/events/'; // + id/verify
}
