import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/intro_screens_controller.dart';

class IntroScreensView extends GetView<IntroScreensController> {
  const IntroScreensView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final color = controller.bgColors[controller.currentPage.value];
        final image = controller.images[controller.currentPage.value];
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: color,
          child: Center(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
        );
      }),
    );
  }
}
