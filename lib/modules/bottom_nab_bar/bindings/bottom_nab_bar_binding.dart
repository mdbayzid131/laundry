import 'package:get/get.dart';
import '../controllers/bottom_nab_bar.dart';
import '../../home/controllers/home_controller.dart';
import '../../search/controllers/search_controller.dart';
import '../../settings/controllers/settings_controller.dart';

class BottomNavBarBinding extends Bindings {  
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavBarController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => SettingsController());
  }
}
