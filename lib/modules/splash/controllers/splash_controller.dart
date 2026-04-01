import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/constants/storage_constants.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/services/storage_service.dart';
import '../../../core/services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find();
  final Color bgColor = const Color(0xFFA6D4E9);
  final String image = ImagePaths.splash2;

  @override
  void onInit() {
    super.onInit();
    navigate();
  }

  Future<void> navigate() async {
    // Basic delay to ensure we don't skip too fast (3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    if (_authService.isLoggedIn.value) {
      Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
    } else {
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
