import 'package:get/get.dart';
import '../controllers/pickup_address_controller.dart';

class PickupAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickupAddressController>(() => PickupAddressController());
  }
}
