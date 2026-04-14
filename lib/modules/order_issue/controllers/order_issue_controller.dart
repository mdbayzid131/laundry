import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/repositories/order_repository.dart';

class OrderIssueController extends GetxController {
  final OrderRepository _orderRepository = Get.find<OrderRepository>();
  
  final issueTypeController = TextEditingController();
  final descriptionController = TextEditingController();
  final submitClaimController = TextEditingController();

  final selectedFileName = ''.obs;
  final selectedImagePath = ''.obs;
  String? orderId;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      orderId = Get.arguments['orderId'];
    }
  }

  @override
  void onClose() {
    issueTypeController.dispose();
    descriptionController.dispose();
    submitClaimController.dispose();
    super.onClose();
  }

  Future<void> pickFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedFileName.value = pickedFile.name;
    }
  }

  Future<void> submitIssue() async {
    if (orderId == null) {
      Helpers.showCustomSnackBar('Order ID is missing', isError: true);
      return;
    }
    if (issueTypeController.text.trim().isEmpty) {
      Helpers.showCustomSnackBar('Please enter issue type', isError: true);
      return;
    }
    if (descriptionController.text.trim().isEmpty) {
      Helpers.showCustomSnackBar('Please enter description', isError: true);
      return;
    }

    isLoading.value = true;
    Helpers.showLoadingDialog();
    try {
      final response = await _orderRepository.submitOrderIssue(
        orderId!,
        issueTypeController.text.trim(),
        descriptionController.text.trim(),
        imagePath: selectedImagePath.value.isNotEmpty ? selectedImagePath.value : null,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back(); // hide loader
        Get.back(); // navigate back from screen
        Helpers.showCustomSnackBar('Order issue submitted successfully', isError: false);
      } else {
        Get.back();
        Helpers.showCustomSnackBar('Failed to submit order issue', isError: true);
      }
    } catch (e) {
      Get.back();
      Helpers.showCustomSnackBar('An error occurred. Please try again.', isError: true);
      Helpers.showDebugLog('Submit Issue Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
