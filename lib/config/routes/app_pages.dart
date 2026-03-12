import 'package:laundry/core/middleware/auth_middleware.dart';
import 'package:laundry/core/widgets/screens/no_internet_screen.dart';
import 'package:laundry/modules/bottom_nab_bar/bindings/bottom_nab_bar_binding.dart';
import 'package:laundry/modules/bottom_nab_bar/views/bottom_nab_bar_view.dart';
import 'package:get/get.dart';
import 'package:laundry/modules/onboarding/binding/onboarding_binding.dart';
import 'package:laundry/modules/onboarding/view/onboarding_screen.dart';
import 'package:laundry/modules/profile/bindings/help_support_binding.dart';
import 'package:laundry/modules/profile/views/contact_support_screen.dart';
import 'package:laundry/modules/profile/views/help_support_screen.dart';
import 'package:laundry/modules/profile/views/live_chat_screen.dart';
import 'package:laundry/modules/profile/views/phone_support_screen.dart';
import 'package:laundry/modules/favorite/views/favorite_view.dart';
import 'package:laundry/modules/favorite/bindings/favorite_binding.dart';
import 'package:laundry/modules/order_tracking/views/order_tracking_view.dart';
import 'package:laundry/modules/order_tracking/bindings/order_tracking_binding.dart';
import 'package:laundry/modules/order_acknowledgment/views/order_acknowledgment_view.dart';
import 'package:laundry/modules/order_acknowledgment/bindings/order_acknowledgment_binding.dart';
import 'package:laundry/modules/payment_method/views/payment_method_view.dart';
import 'package:laundry/modules/payment_method/bindings/payment_method_binding.dart';
import 'package:laundry/modules/card_payment/views/card_payment_view.dart';
import 'package:laundry/modules/card_payment/bindings/card_payment_binding.dart';
import 'package:laundry/modules/order_history/views/order_history_view.dart';
import 'package:laundry/modules/order_history/bindings/order_history_binding.dart';
import 'package:laundry/modules/order_issue/views/order_issue_view.dart';
import 'package:laundry/modules/order_issue/bindings/order_issue_binding.dart';
import 'package:laundry/modules/order_status/views/order_status_view.dart';
import 'package:laundry/modules/order_status/bindings/order_status_binding.dart';
import 'package:laundry/modules/pickup_address/views/pickup_address_view.dart';
import 'package:laundry/modules/pickup_address/bindings/pickup_address_binding.dart';
import 'package:laundry/modules/privacy_security/views/privacy_security_view.dart';
import 'package:laundry/modules/privacy_security/bindings/privacy_security_binding.dart';
import 'package:laundry/modules/legal/views/privacy_policy_view.dart';
import 'package:laundry/modules/legal/views/terms_conditions_view.dart';
import 'package:laundry/modules/legal/bindings/legal_binding.dart';
import 'package:laundry/modules/notifications/views/notifications_view.dart';
import 'package:laundry/modules/notifications/bindings/notifications_binding.dart';
import '../../modules/auth/bindings/auth_binding.dart';
import '../../modules/auth/views/login_view.dart';
import '../../modules/auth/views/register_view.dart';
import '../../modules/auth/views/forgot_password_view.dart';
import '../../modules/auth/views/otp_verify_screen.dart';
import '../../modules/auth/views/set_net_passwqord.dart';
import 'package:laundry/modules/laundry_details/views/laundry_details_view.dart';
import 'package:laundry/modules/laundry_details/bindings/laundry_details_binding.dart';
import 'package:laundry/modules/product_details/bindings/product_details_binding.dart';
import 'package:laundry/modules/product_details/views/product_details_view.dart';

import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/profile/bindings/profile_binding.dart';
import '../../modules/profile/views/profile_view.dart';
import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/views/splash_view.dart';
import '../../modules/splash/views/intro_screens_view.dart';
import '../../modules/splash/bindings/intro_screens_binding.dart';
import '../../modules/map/bindings/map_binding.dart';
import '../../modules/map/views/map_screen.dart';
import '../../modules/cart/bindings/cart_binding.dart';
import '../../modules/cart/views/cart_view.dart';
import '../../modules/checkout/bindings/checkout_binding.dart';
import '../../modules/checkout/views/checkout_view.dart';

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
  static const String CHECKOUT = '/checkout';
  static const String NO_INTERNET = '/no-internet';
  static const String ONBOARDING = '/onboarding';
  static const String OTP = '/otp';
  static const String SET_NEW_PASSWORD = '/set-new-password';
  static const String HELP_SUPPORT = '/help-support';
  static const String CONTACT_SUPPORT = '/contact-support';
  static const String PHONE_SUPPORT = '/phone-support';
  static const String LIVE_CHAT = '/live-chat';
  static const String FAVORITE = '/favorite';
  static const String ORDER_TRACKING = '/order-tracking';
  static const String ORDER_ACKNOWLEDGMENT = '/order-acknowledgment';
  static const String PAYMENT_METHOD = '/payment-method';
  static const String CARD_PAYMENT = '/card-payment';
  static const String ORDER_HISTORY = '/order-history';
  static const String ORDER_ISSUE = '/order-issue';
  static const String ORDER_STATUS = '/order-status';
  static const String PICKUP_ADDRESS = '/pickup-address';
  static const String PRIVACY_SECURITY = '/privacy-security';
  static const String PRIVACY_POLICY = '/privacy-policy';
  static const String TERMS_CONDITIONS = '/terms-conditions';
  static const String NOTIFICATIONS = '/notifications';
  static const String LAUNDRY_DETAILS = '/laundry-details';
  static const String PRODUCT_DETAILS = '/product-details';
  static const String INTRO_SCREENS = '/intro-screens';
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
    name: AppRoutes.CHECKOUT,
    page: () => const CheckoutView(),
    binding: CheckoutBinding(),
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
  GetPage(
    name: AppRoutes.CONTACT_SUPPORT,
    page: () => const ContactSupportScreen(),
    binding: HelpSupportBinding(),
    // middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.PHONE_SUPPORT,
    page: () => const PhoneSupportScreen(),
    binding: HelpSupportBinding(),
    // middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.LIVE_CHAT,
    page: () => const LiveChatScreen(),
    binding: HelpSupportBinding(),
    // middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.FAVORITE,
    page: () => const FavoriteView(),
    binding: FavoriteBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.ORDER_TRACKING,
    page: () => const OrderTrackingView(),
    binding: OrderTrackingBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.ORDER_ACKNOWLEDGMENT,
    page: () => const OrderAcknowledgmentView(),
    binding: OrderAcknowledgmentBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.PAYMENT_METHOD,
    page: () => const PaymentMethodView(),
    binding: PaymentMethodBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.CARD_PAYMENT,
    page: () => const CardPaymentView(),
    binding: CardPaymentBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.ORDER_HISTORY,
    page: () => const OrderHistoryView(),
    binding: OrderHistoryBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.ORDER_ISSUE,
    page: () => const OrderIssueView(),
    binding: OrderIssueBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.ORDER_STATUS,
    page: () => const OrderStatusView(),
    binding: OrderStatusBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.PICKUP_ADDRESS,
    page: () => const PickupAddressView(),
    binding: PickupAddressBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.PRIVACY_SECURITY,
    page: () => const PrivacySecurityView(),
    binding: PrivacySecurityBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.PRIVACY_POLICY,
    page: () => const PrivacyPolicyView(),
    binding: LegalBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.TERMS_CONDITIONS,
    page: () => const TermsConditionsView(),
    binding: LegalBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.NOTIFICATIONS,
    page: () => const NotificationsView(),
    binding: NotificationsBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.LAUNDRY_DETAILS,
    page: () => const LaundryDetailsView(),
    binding: LaundryDetailsBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutes.PRODUCT_DETAILS,
    page: () => const ProductDetailsView(),
    binding: ProductDetailsBinding(),
  ),
  GetPage(
    name: AppRoutes.INTRO_SCREENS,
    page: () => const IntroScreensView(),
    binding: IntroScreensBinding(),
  ),
];
