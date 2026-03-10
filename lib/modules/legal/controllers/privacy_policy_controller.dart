import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  final isAgreed = false.obs;

  void toggleAgreement(bool? value) {
    isAgreed.value = value ?? false;
  }

  void acceptPolicy() {
    if (isAgreed.value) {
      Get.back();
      // Logic for saving status if needed.
    }
  }
}
