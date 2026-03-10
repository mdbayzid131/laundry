import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  final selectedMethod = 'card'.obs;

  void selectMethod(String method) => selectedMethod.value = method;
}
