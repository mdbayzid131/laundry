import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffABD4E7),
      body: Center(
        child: Obx(() {
          if (controller.isVideoInitialized.value) {
            return SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: 428.w,
                  height: 350.h,
                  child: VideoPlayer(controller.videoController),
                ),
              ),
            );
          } else {
            // Fallback while video is initializing (empty screen with background color)
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
