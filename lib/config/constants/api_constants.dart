class ApiConstants {
  // Base URLs
  static const String baseUrl = 'http://10.10.7.111:5000/api/v1';
  // static const String apiVersion = '/api/v1';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String signup = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forget-password-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String verifyUser = '/auth/verify-user';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';

  // User Profile Endpoints
  static const String profile = '/user/get-me';
  // Category Endpoints
  static const String category = '/category';
  // Banner Endpoints
  static const String banner = '/banner';

  // Service Endpoints
  static const String getStoreService = '/storeservice';
  static const String getStoreServiceDetails = '/storeservice/:storeServiceId';
}
