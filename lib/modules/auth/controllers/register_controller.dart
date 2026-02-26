import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';

class RegisterController extends GetxController {
  final AuthService _authService = Get.find();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      await _authService.signup(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
        country: countryController.text,
      );

      Helpers.showCustomSnackBar(
        'Registration successful',

      );
      Get.offAllNamed(AppRoutes.LOGIN);
    } catch (e) {
      Helpers.showCustomSnackBar(
        e.toString(),

      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.back();
  }
}
