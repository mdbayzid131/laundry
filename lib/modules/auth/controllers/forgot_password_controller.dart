import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Future<void> sendResetLink() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      await _authService.forgotPassword(emailController.text);

      Helpers.showCustomSnackBar(
        'Reset link sent to your email',
      );
      Get.back();
    } catch (e) { 
      Helpers.showCustomSnackBar(
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
