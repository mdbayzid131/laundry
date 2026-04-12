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
  static const String notificationPreferences = '/user/notification-preferences';
  // Category Endpoints
  static const String category = '/category';
  static const String getOperatorCategory = '/operatorcategory/:id';
  // Banner Endpoints
  static const String banner = '/banner';
  static const String ads = '/ad';

  // Service Endpoints
  static const String getStoreService = '/storeservice';
  static const String getStoreServiceDetails = '/storeservice/:storeServiceId';

  // Address Endpoints
  static const String getAddresses = '/address/my-addresses';
  static const String updateAddress = '/address';
  static const String setDefaultAddress = '/address/:addressId/set-default';

  // Cart Endpoints
  static const String addToCart = '/cart/add';
  static const String getMyCart = '/cart/my-cart';
  static const String updateCartQuantity = '/cart/update-quantity/:cartItemId';
  static const String deleteCartItem = '/cart/item/:cartItemId';

  // Order Endpoints
  static const String myOrders = '/order/my-orders';
  static const String checkout = '/order/checkout';

  // Store Endpoints
  static const String getStoreDetails = '/store/:id';
  static const String getStoreServiceByStoreId = '/storeservice/store/:storeId';
  static const String getStoreBundleByStoreId = '/storebundle/store/:storeId';

  // Review Endpoints
  static const String review = '/review';
  static const String getStoreServiceReviews = '/review/store-service/:storeServiceId';

  // Support Endpoints
  static const String emailSupport = '/email-support';
  static const String phoneSupport = '/support-phone';
  static const String faq = '/faq';

  // Favorite Endpoints
  static const String myFavorites = '/favouriteservice/my-favourites';
  static const String toggleFavorite = '/favouriteservice';

  // Notification Endpoints
  static const String myNotifications = '/notification/my-notifications';
  static const String markAllRead = '/notification/mark-all-read';
  static const String markSingleRead =
      '/notification/:notificationId/mark-read';
}
