
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
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
      Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
    } else {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}
