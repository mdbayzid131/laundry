import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'dart:async';

class IntroScreensController extends GetxController {
  final currentPage = 0.obs;
  late Timer _timer;

  final List<Color> bgColors = [
    const Color(0xFFFFFFFF),
    const Color(0xFFA6D4E9),
    const Color(0xFF000000),
  ];

  final List<String> images = [
    ImagePaths.splash1,
    ImagePaths.splash2,
    ImagePaths.splash3,
  ];

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage.value < images.length - 1) {
        currentPage.value++;
      } else {
        _timer.cancel();
        Get.offAllNamed(AppRoutes.ONBOARDING);
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
