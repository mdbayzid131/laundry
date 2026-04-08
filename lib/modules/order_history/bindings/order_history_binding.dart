import 'package:get/get.dart';
import 'package:laundry/data/repositories/order_repository.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderRepository>(() => OrderRepository());
    Get.lazyPut<OrderHistoryController>(() => OrderHistoryController());
  }
}
