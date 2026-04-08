import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/services/api_checker.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';

class RegisterController extends GetxController {
  final AuthService _authService = Get.find();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
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

      final response = await _authService.signup(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
        address: addressController.text,
      );
      ApiChecker.checkWriteApi(response);
      if (response.statusCode == 201) {
        Helpers.showCustomSnackBar('Registration successful', isError: false);
        Get.offAllNamed(AppRoutes.OTP_FORM_REGISTER, arguments: {
          'email': emailController.text,
          'isRegister': true,
        });


      }
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.back();
  }
}
