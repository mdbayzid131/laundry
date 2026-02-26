import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/constants/image_paths.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              ImagePaths.splashImage1,  
              height: 311,
              width: 311,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20),
            
            // App Name
            const Text(
              'Flutter App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            
            // Loading Indicator
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
