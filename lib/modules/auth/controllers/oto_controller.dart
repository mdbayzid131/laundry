import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/services/auth_service.dart';
import 'package:laundry/core/utils/helpers.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
    final AuthService _authService = Get.find();
  final arguments = Get.arguments;
  late String email = arguments['email'];
  late bool isRegister = arguments['isRegister'];

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  void verifyOtp() async {
    int oneTimeCode = int.parse(otpController.text);
   final response = await _authService.verifyOtp(email: email, otp: oneTimeCode);
   if (response.statusCode == 200) {  
    Helpers.showCustomSnackBar("OTP Verified");
   } else {
    Helpers.showCustomSnackBar("OTP Verification Failed");
   }
    Get.toNamed(AppRoutes.SET_NEW_PASSWORD);
    Get.back();
  }  

}
