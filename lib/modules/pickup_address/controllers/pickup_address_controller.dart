import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickupAddressController extends GetxController {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void onClose() {
    dateController.dispose();
    timeController.dispose();
    addressController.dispose();
    super.onClose();
  }

  void saveAddress() {
    // Save logic here.
    Get.back();
    Get.snackbar('Success', 'Pickup address added successfully');
  }
}
