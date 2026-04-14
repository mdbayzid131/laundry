import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/order_issue_model.dart';
import 'package:laundry/data/repositories/order_repository.dart';

class MyIssuesController extends GetxController {
  final OrderRepository _orderRepository = Get.find<OrderRepository>();
  
  RxList<OrderIssue> issuesList = <OrderIssue>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyIssues();
  }

  Future<void> fetchMyIssues() async {
    isLoading.value = true;
    try {
      final response = await _orderRepository.getMyOrderIssues();
      if (response.statusCode == 200) {
        final data = OrderIssueResponse.fromJson(response.data);
        if (data.data != null) {
          issuesList.assignAll(data.data!);
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Fetch My Issues Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
