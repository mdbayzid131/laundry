import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'dart:async';

class IntroScreensController extends GetxController {
  late Timer _timer;

  final Color bgColor = const Color(0xFFA6D4E9);
  final String image = ImagePaths.splash2;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.ONBOARDING);
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
