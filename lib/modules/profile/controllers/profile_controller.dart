import 'package:get/get.dart';
import '../../../core/services/auth_service.dart';
import '../../../config/routes/app_pages.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find();

  final userName = 'John Doe'.obs;
  final userEmail = 'john.doe@example.com'.obs;

  void updateProfile() {
    // Update profile logic
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      Get.offAllNamed(AppRoutes.LOGIN);
    } catch (e) {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}
