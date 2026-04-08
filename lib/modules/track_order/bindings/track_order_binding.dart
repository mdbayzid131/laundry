import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:laundry/modules/track_order/controllers/track_order_controller.dart';

class TrackOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackOrderController>(() => TrackOrderController(), fenix: true);
  }
}
  