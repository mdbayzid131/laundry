import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/active_order_model.dart';
import 'package:laundry/data/repositories/order_repository.dart';

class OrderTrackingController extends GetxController {
  final OrderRepository _orderRepository = Get.find<OrderRepository>();

  final RxBool isLoading = false.obs;
  final Rxn<ActiveOrder> order = Rxn<ActiveOrder>();
  String? orderId;

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments as String?;
    if (orderId != null) {
      getOrderDetails();
    }
  }

  Future<void> getOrderDetails() async {
    if (orderId == null) return;
    
    isLoading.value = true;
    try {
      final response = await _orderRepository.getOrderDetails(orderId!);
      if (response.statusCode == 200) {
        // The API response for a single order might be wrapped in a 'data' field
        // and might need to be parsed into ActiveOrder.
        // Assuming the response matches the ActiveOrder structure under 'data'.
        final Map<String, dynamic> data = response.data['data'];
        order.value = ActiveOrder.fromJson(data);
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching order details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
