import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      await _authService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      Helpers.showCustomSnackBar('Login successful');
      Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
    } catch (e) {
      Helpers.showCustomSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  void goToHome() {
    // Temporarily set isLoggedIn to true to bypass AuthMiddleware
    _authService.isLoggedIn.value = true;
    Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
  }

  void goToForgotPassword() {
    Get.toNamed(AppRoutes.FORGOT_PASSWORD);
  }
}
