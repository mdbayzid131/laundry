import 'package:laundry/core/middleware/auth_middleware.dart';
import 'package:laundry/core/widgets/screens/no_internet_screen.dart';
import 'package:laundry/modules/bottom_nab_bar/bindings/bottom_nab_bar_binding.dart';
import 'package:laundry/modules/bottom_nab_bar/views/bottom_nab_bar_view.dart'; 
import 'package:get/get.dart';
import '../../modules/auth/bindings/auth_binding.dart';
import '../../modules/auth/views/login_view.dart';
import '../../modules/auth/views/register_view.dart';
import '../../modules/auth/views/forgot_password_view.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/profile/bindings/profile_binding.dart';
import '../../modules/profile/views/profile_view.dart';
import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/views/splash_view.dart';
import '../../modules/search/bindings/search_binding.dart';
import '../../modules/search/views/search_view.dart';
import '../../modules/settings/bindings/settings_binding.dart';
import '../../modules/settings/views/settings_view.dart';




class AppRoutes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String FORGOT_PASSWORD = '/forgot-password';
  static const String HOME = '/home';
  static const String PROFILE = '/profile';
  static const String BOTTOM_NAV_BAR = '/bottom-nav-bar';
  static const String SEARCH = '/search';
  static const String SETTINGS = '/settings';
  static const String NO_INTERNET = '/no-internet';
}





   final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.BOTTOM_NAV_BAR,
      page: () => const BottomNavBarView(),
      binding: BottomNavBarBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware()],  
    ),
    GetPage(
      name: AppRoutes.SEARCH, 
      page: () => const SearchView(),
      binding: SearchBinding(),
      middlewares: [AuthMiddleware()],  
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      middlewares: [AuthMiddleware()],  
    ),
    GetPage(
      name: AppRoutes.NO_INTERNET,
      page: () => const NoInternetScreen(),
      // binding: NoInternetBinding(),
    ),
      ];

