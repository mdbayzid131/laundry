import 'package:get/get.dart';
import 'package:laundry/modules/profile/controllers/profile_controller.dart';
import '../controllers/bottom_nab_bar.dart';
import '../../home/controllers/home_controller.dart';
import '../../map/controllers/map_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavBarController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => MapController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => ProfileController());
  }
}
