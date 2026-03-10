import 'package:get/get.dart';

class PrivacySecurityController extends GetxController {
  final savedPayments = [
    PaymentMethodModel(brand: 'Visa', last4: '4532', expiry: '08/26'),
    PaymentMethodModel(brand: 'Mastercard', last4: '8910', expiry: '12/25'),
  ].obs;

  void removePayment(int index) {
    savedPayments.removeAt(index);
  }
}

class PaymentMethodModel {
  final String brand;
  final String last4;
  final String expiry;

  PaymentMethodModel({
    required this.brand,
    required this.last4,
    required this.expiry,
  });
}
