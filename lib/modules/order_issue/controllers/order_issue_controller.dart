import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderIssueController extends GetxController {
  final issueTypeController = TextEditingController();
  final descriptionController = TextEditingController();
  final submitClaimController = TextEditingController();

  final selectedFileName = ''.obs;

  @override
  void onClose() {
    issueTypeController.dispose();
    descriptionController.dispose();
    submitClaimController.dispose();
    super.onClose();
  }

  void pickFile() {
    // Logic to pick a file (image) goes here.
    // Setting a dummy file name for now.
    selectedFileName.value = "Selected_Image.png";
  }

  void submitIssue() {
    // Logic to submit the issue goes here.
    Get.back();
    Get.snackbar('Success', 'Order issue submitted successfully');
  }
}
