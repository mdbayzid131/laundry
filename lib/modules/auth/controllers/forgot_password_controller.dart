import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/services/api_checker.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _authService = Get.find();

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> forgotPassword() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      var response = await _authService.forgotPassword(emailController.text);
      ApiChecker.checkWriteApi(response);
      if (response.statusCode == 200) {
        Helpers.showCustomSnackBar(
          "Reset link sent to your email",
          isError: false,
        );
        Get.toNamed(
          AppRoutes.OTP,
          arguments: {'email': emailController.text, 'isForgotPassword': true},
        );
      }
    } catch (e) {
      Helpers.showCustomSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
