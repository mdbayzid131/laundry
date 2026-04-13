import 'package:get/get.dart';
import 'package:laundry/data/models/order_model.dart';

class TrackOrderController extends GetxController {
  final order = Rxn<Order>();
  final currentStep = 0.obs;

  final isCancelled = false.obs;
  final isRefunded = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Order) {
      order.value = Get.arguments;
      _calculateCurrentStep();
    }
  }

  void _calculateCurrentStep() {
    if (order.value == null) return;
    final status = order.value!.status?.toUpperCase() ?? '';

    isCancelled.value = status == 'CANCELLED';
    isRefunded.value = status == 'REFUNDED';

    switch (status) {
      case 'PENDING':
        currentStep.value = 0;
        break;
      case 'PROCESSING':
        currentStep.value = 1;
        break;
      case 'OUT_FOR_PICKUP':
        currentStep.value = 2;
        break;
      case 'PICKED_UP':
        currentStep.value = 3;
        break;
      case 'RECEIVED_BY_STORE':
        currentStep.value = 4;
        break;
      case 'IN_PROGRESS':
        currentStep.value = 5;
        break;
      case 'READY_FOR_DELIVERY':
        currentStep.value = 6;
        break;
      case 'OUT_FOR_DELIVERY':
        currentStep.value = 7;
        break;
      case 'DELIVERED':
      case 'COMPLETED': // Some fallback
        currentStep.value = 8;
        break;
      default:
        currentStep.value = 0; // Or whatever fallback
    }
  }
}
