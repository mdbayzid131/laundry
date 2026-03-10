import 'package:get/get.dart';
import '../controllers/order_issue_controller.dart';

class OrderIssueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderIssueController>(() => OrderIssueController());
  }
}
