import 'package:get/get.dart';
import 'package:laundry/config/constants/storage_constants.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/services/storage_service.dart';
import '../../../core/services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find();

  @override
  void onInit() {
    super.onInit();
    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (_authService.isLoggedIn.value) {
      // User is logged in → go to Bottom Nav Bar
      Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
    } else {
      // User is not logged in → check if onboarding was already seen
      final onboardingSeen = await StorageService.getBool(
        StorageConstants.onboardingSeen,
      );
      if (onboardingSeen == true) {
        Get.offAllNamed(AppRoutes.LOGIN);
      } else {
        Get.offAllNamed(AppRoutes.ONBOARDING);
      }
    }
  }
}
