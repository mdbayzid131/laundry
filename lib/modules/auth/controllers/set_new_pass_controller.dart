import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/services/auth_service.dart';
import 'package:laundry/core/utils/helpers.dart';

class SetNewPassController extends GetxController {
  final AuthService _authService = Get.find();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  late final String resetToken;
  final isLoading = false.obs;
  late final String email;

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  final hasMinLength = false.obs;
  final hasUpperCase = false.obs;
  final hasLowerCase = false.obs;
  final hasNumberOrSpecial = false.obs;

  onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      resetToken = args['resetToken'] ?? '';
      email = args['email'] ?? '';
      return;
    } else {
      resetToken = '';
      email = '';
    }
  }

  void validatePasswordRules(String text) {
    hasMinLength.value = text.length >= 8;
    hasUpperCase.value = text.contains(RegExp(r'[0-9]'));
    hasNumberOrSpecial.value = text.contains(
      RegExp(r'[!@#\$&*~`%\^\(\)\-_=\+\[\{\]\}\|;:\x27",<\.>\/\?]'),
    );
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> submitNewPassword() async {
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Helpers.showCustomSnackBar('Please enter a password');
      return;
    }
    if (confirmPasswordController.text.isEmpty !=
        confirmPasswordController.text.isEmpty) {
      Helpers.showCustomSnackBar('Please confirm the password');
      return;
    }
    if (!hasMinLength.value ||
        !hasUpperCase.value ||
        !hasNumberOrSpecial.value) {
      Helpers.showCustomSnackBar(
        'Password must contain at least 8 characters, including uppercase, lowercase, and special characters',
      );
      return;
    }
    try {
      isLoading.value = true;
      var response = await _authService.resetPassword(
        resetToken: resetToken,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helpers.showCustomSnackBar('Password set successfully', isError: false);
        Get.offAllNamed(AppRoutes.LOGIN);
      }
    } catch (e) {
      Helpers.showCustomSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}