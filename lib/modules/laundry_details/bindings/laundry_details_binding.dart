import 'package:get/get.dart';
import '../controllers/laundry_details_controller.dart';

class LaundryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaundryDetailsController>(() => LaundryDetailsController());
  }
}
