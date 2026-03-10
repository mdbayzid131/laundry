import 'package:get/get.dart';
import '../controllers/order_acknowledgment_controller.dart';

class OrderAcknowledgmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderAcknowledgmentController>(
      () => OrderAcknowledgmentController(),
    );
  }
}
