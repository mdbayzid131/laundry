// ignore: implementation_imports
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:laundry/core/services/api_checker.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/helpers.dart';

class ChangePasswordController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final obscureOldPassword = true.obs;
  final obscureNewPassword = true.obs;
  final obscureConfirmPassword = true.obs;

  final formKey = GlobalKey<FormState>();

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      Response<dynamic> response = await _authService.changePassword(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
      );
      ApiChecker.checkWriteApi(response);
      if (response.statusCode == 200) {
        Helpers.showCustomSnackBar(
          'Password changed successfully',
          isError: false,
        );
        Navigator.pop(Get.context!);
      }
    } catch (e) {
      Helpers.showCustomSnackBar(e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
