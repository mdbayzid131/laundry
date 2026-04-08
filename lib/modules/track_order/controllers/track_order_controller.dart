import 'package:get/get.dart';
import 'package:laundry/data/models/order_model.dart';

class TrackOrderController extends GetxController {
  final order = Rxn<Order>();
  final currentStep = 0.obs;

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
    
    switch (status) {
      case 'PENDING':
        currentStep.value = 0;
        break;
      case 'PICKED_UP':
        currentStep.value = 1;
        break;
      case 'PROCESSING':
        currentStep.value = 2;
        break;
      case 'READY_FOR_DELIVERY':
        currentStep.value = 3;
        break;
      case 'OUT_FOR_DELIVERY':
        currentStep.value = 4;
        break;
      case 'COMPLETED':
        currentStep.value = 5;
        break;
      default:
        currentStep.value = 0;
    }
  }
}
