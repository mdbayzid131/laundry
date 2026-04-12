import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/core/services/api_checker.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/repositories/contract_support_repository.dart';
import 'package:laundry/modules/profile/controllers/profile_controller.dart';

class ContactSupportController extends GetxController {
  final ContactSupportRepository _repository =
      Get.find<ContactSupportRepository>();
  final ProfileController _profileController = Get.find<ProfileController>();

  final subjectController = TextEditingController();
  final orderIdController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final isLoading = false.obs;

  Future<void> sendSupportMessage() async {
    isLoading.value = true;

    Map<String, dynamic> body = {
      "subject": subjectController.text,
      "orderId": orderIdController.text.isNotEmpty
          ? orderIdController.text
          : "",
      "email": emailController.text,
      "message": messageController.text,
      "userId": _profileController.userData.value?.id,
      "name": _profileController.userData.value?.name,
    };

    try {
      final response = await _repository.sendSupportEmail(body);
      ApiChecker.checkWriteApi(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helpers.showCustomSnackBar(
          'Message sent successfully!',
          isError: false,
        );
        _clearFields();
        Navigator.pop(Get.context!);
      }
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _clearFields() {
    subjectController.clear();
    orderIdController.clear();
    emailController.clear();
    messageController.clear();
  }

  @override
  void onClose() {
    subjectController.dispose();
    orderIdController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
