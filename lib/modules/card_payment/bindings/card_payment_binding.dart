import 'package:get/get.dart';
import '../controllers/card_payment_controller.dart';

class CardPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardPaymentController>(() => CardPaymentController());
  }
}
