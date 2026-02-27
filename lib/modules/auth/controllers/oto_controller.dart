import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  void verifyOtp() {
    Get.toNamed(AppRoutes.SET_NEW_PASSWORD);
  }
}
