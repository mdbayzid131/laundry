import 'package:laundry/core/middleware/auth_middleware.dart';
import 'package:laundry/core/widgets/screens/no_internet_screen.dart';
import 'package:laundry/modules/bottom_nab_bar/bindings/bottom_nab_bar_binding.dart';
import 'package:laundry/modules/bottom_nab_bar/views/bottom_nab_bar_view.dart';
import 'package:get/get.dart';
import 'package:laundry/modules/onboarding/binding/onboarding_binding.dart';
import 'package:laundry/modules/onboarding/view/onboarding_screen.dart';
import 'package:laundry/modules/profile/bindings/help_support_binding.dart';
import 'package:laundry/modules/profile/views/help_support_screen.dart';
import '../../modules/auth/bindings/auth_binding.dart';
import '../../modules/auth/views/login_view.dart';
import '../../modules/auth/views/register_view.dart';
import '../../modules/auth/views/forgot_password_view.dart';
import '../../modules/auth/views/otp_verify_screen.dart';
import '../../modules/auth/views/set_net_passwqord.dart';

import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/profile/bindings/profile_binding.dart';
import '../../modules/profile/views/profile_view.dart';
import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/views/splash_view.dart';
import '../../modules/map/bindings/map_binding.dart';
import '../../modules/map/views/map_screen.dart';
import '../../modules/cart/bindings/cart_binding.dart';
import '../../modules/cart/views/cart_view.dart';

class AppRoutes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String FORGOT_PASSWORD = '/forgot-password';
  static const String HOME = '/home';
  static const String PROFILE = '/profile';
  static const String BOTTOM_NAV_BAR = '/bottom-nav-bar';
  static const String MAP = '/map';
  static const String CART = '/cart';
  static const String NO_INTERNET = '/no-internet';
  static const String ONBOARDING = '/onboarding';
  static const String OTP = '/otp';
  static const String SET_NEW_PASSWORD = '/set-new-password';
  static const String HELP_SUPPORT = '/help-support';
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
    page: () => const LaundryHomeScreen(),
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
    name: AppRoutes.MAP,
    page: () => const MapScreen(),
    binding: MapBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.CART,
    page: () => const CartScreen(),
    binding: CartBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.NO_INTERNET,
    page: () => const NoInternetScreen(),
    // binding: NoInternetBinding(),
  ),
  GetPage(
    name: AppRoutes.ONBOARDING,
    page: () => const OnboardingScreen(),
    binding: OnboardingBinding(),
  ),
  GetPage(
    name: AppRoutes.OTP,
    page: () => const OtpVerifyScreen(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: AppRoutes.SET_NEW_PASSWORD,
    page: () => const SetNewPasswordScreen(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: AppRoutes.HELP_SUPPORT,
    page: () => const HelpSupportScreen(),
    binding: HelpSupportBinding(),
    // middlewares: [AuthMiddleware()],
  ),
];
