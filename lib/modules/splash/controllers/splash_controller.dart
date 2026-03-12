import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/constants/storage_constants.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/services/storage_service.dart';
import '../../../core/services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find();
  late VideoPlayerController videoController;
  final isVideoInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeVideo();
    navigate(); // Start navigation timer
  }

  void _initializeVideo() {
    print("Initializing video: ${ImagePaths.splashVideo1}");
    videoController = VideoPlayerController.asset(ImagePaths.splashVideo1)
      ..initialize().then((_) {
        print("Video initialized successfully");
        isVideoInitialized.value = true;
        videoController.setVolume(0); 
        videoController.setLooping(true); // Loop video
        videoController.play();
        
        update(); 
      }).catchError((error) {
        print("Video initialization error: $error");
      });
  }

  Future<void> navigate() async {
    // Basic delay to ensure we don't skip too fast (1 second fallback)
    await Future.delayed(const Duration(seconds: 8));

    if (_authService.isLoggedIn.value) {
      Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
    } else {
      final onboardingSeen = await StorageService.getBool(
        StorageConstants.onboardingSeen,
      );
      if (onboardingSeen == true) {
        Get.offAllNamed(AppRoutes.LOGIN);
      } else {
        Get.offAllNamed(AppRoutes.INTRO_SCREENS);
      }
    }
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
