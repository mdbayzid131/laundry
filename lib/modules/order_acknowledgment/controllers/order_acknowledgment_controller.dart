import 'package:get/get.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../data/models/check_out_model.dart';
import '../../../config/routes/app_pages.dart';

class OrderAcknowledgmentController extends GetxController {
  final OrderRepository _orderRepository = Get.find<OrderRepository>();

  final checkedPockets = false.obs;
  final delicateItemsMarked = false.obs;
  final wearAndTearLiability = false.obs;
  
  RxBool isLoading = false.obs;

  // Checkout Params
  DateTime? pickupDate;
  String? pickupTime;
  String? streetAddress;
  String? city;
  String? state;
  String? zipCode;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      pickupDate = Get.arguments['pickupDate'];
      pickupTime = Get.arguments['pickupTime'];
      streetAddress = Get.arguments['streetAddress'];
      city = Get.arguments['city'];
      state = Get.arguments['state'];
      zipCode = Get.arguments['zipCode'];
    }
  }

  bool get isAllChecked =>
      checkedPockets.value &&
      delicateItemsMarked.value &&
      wearAndTearLiability.value;

  void togglePockets(bool? value) => checkedPockets.value = value ?? false;
  void toggleDelicate(bool? value) =>
      delicateItemsMarked.value = value ?? false;
  void toggleLiability(bool? value) =>
      wearAndTearLiability.value = value ?? false;

  Future<void> checkout() async {
    if (!isAllChecked) {
      Helpers.showCustomSnackBar('Please check all internal requirements');
      return;
    }

    isLoading.value = true;
    try {
      final body = {
        "pickupAddress": {
          "pickupTime": pickupTime ?? "10:00 AM",
          "streetAddress": streetAddress ?? "",
          "city": city ?? "",
          "state": state ?? "",
          "country": "Bangladesh",
          "postalCode": zipCode ?? ""
        },
        "deliveryAddress": {
          "streetAddress": streetAddress ?? "",
          "city": city ?? "",
          "state": state ?? "",
          "country": "Bangladesh",
          "postalCode": zipCode ?? ""
        },
        "scheduledDate": pickupDate?.toIso8601String() ?? DateTime.now().toIso8601String()
      };

      final response = await _orderRepository.checkout(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final checkoutResponse = CheckoutResponseModel.fromJson(response.data);
        Helpers.showCustomSnackBar('Order initiated successfully', isError: false);
        // Navigate with order details if needed, for now as per user request to PAYMENT_METHOD
        Get.toNamed(AppRoutes.PAYMENT_METHOD, arguments: {
          'orderId': checkoutResponse.data?.orderId,
          'paymentUrl': checkoutResponse.data?.paymentUrl,
        });
      }
    } catch (e) {
      Helpers.showDebugLog('Checkout Error: $e');
      Helpers.showCustomSnackBar('Failed to initiate checkout');
    } finally {
      isLoading.value = false;
    }
  }
}
