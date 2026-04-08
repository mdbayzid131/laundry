class ApiConstants {
  // Base URLs
  static const String baseUrl = 'http://10.10.7.111:5000/api/v1';
  static const String apiVersion = '';
  
  // Auth Endpoints
  static const String login = '/auth/login';
  static const String signup = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/reset-password';
  static const String category = '/category';
  
  // User Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';
  
  // Add your API endpoints here
  static const String resendVerifyEmail = '/auth/resend-verify-email';
  static const String verifyUser = '/auth/verify-user';
  static const String resetPassword = '/auth/reset-password';
  

}
