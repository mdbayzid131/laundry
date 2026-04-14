import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/order_issue_model.dart';
import 'package:laundry/data/repositories/order_repository.dart';

class IssueDetailsController extends GetxController {
  final OrderRepository _orderRepository = Get.find<OrderRepository>();
  
  final Rx<OrderIssue?> issue = Rx<OrderIssue?>(null);
  final RxBool isLoading = true.obs;
  String? issueId;

  @override
  void onInit() {
    super.onInit();
    issueId = Get.arguments['issueId'];
    if (issueId != null) {
      fetchIssueDetails();
    } else {
      isLoading.value = false;
      Helpers.showCustomSnackBar('Issue ID not found', isError: true);
    }
  }

  Future<void> fetchIssueDetails() async {
    isLoading.value = true;
    try {
      final response = await _orderRepository.getOrderIssueDetails(issueId!);
      if (response.statusCode == 200) {
        final data = SingleOrderIssueResponse.fromJson(response.data);
        issue.value = data.data;
      }
    } catch (e) {
      Helpers.showDebugLog('Fetch Issue Details Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
