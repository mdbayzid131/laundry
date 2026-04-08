import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/services/api_checker.dart';
import 'package:laundry/core/services/auth_service.dart';
import 'package:laundry/core/utils/helpers.dart';

class OtpController extends GetxController {
  
  // ================== Controllers ==================
  final otpController = TextEditingController();

  // ================== Services ==================
  final AuthService _authService = Get.find<AuthService>();

  // ================== Variables ==================
  late String email;
  late bool isForgotPassword;     // Forgot Password থেকে এসেছে কিনা
  late bool isRegister;           // রেজিস্ট্রেশন থেকে এসেছে কিনা

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Get.arguments থেকে ডাটা নিয়ে আসা
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};

    email = arguments['email'] ?? '';
    isRegister = arguments['isRegister'] ?? false;
    isForgotPassword = arguments['isForgotPassword'] ?? false;

    if (email.isEmpty) {
      Helpers.showCustomSnackBar("Email not found!", isError: true);
      Get.back();
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  // ================== Verify OTP ==================
  Future<void> verifyOtp() async {
    if (otpController.text.length != 6) {
      Helpers.showCustomSnackBar("Please enter 6 digit OTP", isError: true);
      return;
    }

    try {
      isLoading.value = true;
      Helpers.showLoadingDialog();

      final int otp = int.parse(otpController.text.trim());

      final response = await _authService.verifyOtp(
        email: email,
        otp: otp,
      );

      // API Response চেক
      ApiChecker.checkWriteApi(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        
        Helpers.hideLoadingDialog();
        Helpers.showCustomSnackBar("OTP Verified Successfully!", isError: false);

        if (isForgotPassword) {
          // Forgot Password এর ক্ষেত্রে Reset Token নিয়ে নতুন পাসওয়ার্ড সেট করতে যাবে
          final resetToken = response.data['resetToken'];
          Get.toNamed(
            AppRoutes.SET_NEW_PASSWORD,
            arguments: {"resetToken": resetToken},
          );
        } else {
          // সাধারণ রেজিস্ট্রেশন / লগইন
          _authService.handleAuthResponse(response);
          Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
        }
      }
    } catch (e) {
      Helpers.hideLoadingDialog();
      Helpers.showCustomSnackBar(e.toString(), isError: true);
      Helpers.showDebugLog("OTP Verify Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ================== Resend OTP ==================
  Future<void> resendOtp() async {
    try {
      isLoading.value = true;
      Helpers.showLoadingDialog();

      if (isForgotPassword) {
        await _authService.forgotPassword(email);
      } else {
        await _authService.resendOtp(email);
      }

      Helpers.hideLoadingDialog();
      Helpers.showCustomSnackBar("OTP has been resent successfully!", isError: false);
    } catch (e) {
      Helpers.hideLoadingDialog();
      Helpers.showCustomSnackBar("Failed to resend OTP", isError: true);
      Helpers.showDebugLog(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}