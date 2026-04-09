import 'package:get/get.dart';
import 'package:laundry/core/services/api_checker.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/order_model.dart';
import 'package:laundry/data/repositories/order_repository.dart';

class OrderHistoryController extends GetxController {
  final OrderRepository _repository = Get.find<OrderRepository>();

  final selectedTab = 'All Orders'.obs;
  final tabs = [
    'All Orders',
    'Pending',
    'Picked up',
    'Processing',
    'Ready for delivery',
    'Completed',
    'Cancelled',
  ];

  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final hasMoreData = true.obs;
  final currentPage = 1.obs;
  final limit = 10;

  final allOrders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoadingMore.value || !hasMoreData.value) return;
      isLoadingMore.value = true;
      currentPage.value++;
    } else {
      isLoading.value = true;
      currentPage.value = 1;
      allOrders.clear();
      hasMoreData.value = true;
    }

    try {
      final response = await _repository.getMyOrders(
        page: currentPage.value,
        limit: limit,
      );
      ApiChecker.checkGetApi(response);
      if (response.statusCode == 200 && response.data != null) {
        final orderResponse = MyOrderResponseModel.fromJson(response.data);
        final List<Order> orders = orderResponse.data ?? [];

        if (orders.length < limit) {
          hasMoreData.value = false;
        }
        allOrders.addAll(orders);
      } else {
        hasMoreData.value = false;
      }
    } catch (e) {
      Helpers.showDebugLog("order hidtry error $e");
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  List<Order> get filteredOrders {
    if (selectedTab.value == 'All Orders') return allOrders;
    return allOrders
        .where(
          (order) =>
              order.status?.toUpperCase().replaceAll('_', ' ') ==
              selectedTab.value.toUpperCase(),
        )
        .toList();
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }
}
