import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardPaymentController extends GetxController {
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final nameController = TextEditingController();

  final saveCard = true.obs;

  @override
  void onClose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
