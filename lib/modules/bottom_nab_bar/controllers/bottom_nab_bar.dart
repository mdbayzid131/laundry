import 'package:laundry/config/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:laundry/modules/cart/controllers/cart_controller.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';

class BottomNavBarController extends GetxController {
  final AuthService _authService = Get.find();

  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
    
    // If the Cart tab (index 2) is selected, refresh the cart data
    if (index == 2) {
      if (Get.isRegistered<CartController>()) {
        Get.find<CartController>().getCart();
      }
    }
  }

  void goToProfile() {
    Get.toNamed(AppRoutes.PROFILE);
  }

  Future<void> logout() async {
    Helpers.showLoadingDialog();

    await _authService.logout();

    Helpers.hideLoadingDialog();
    Helpers.showCustomSnackBar('Logged out successfully');

    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
