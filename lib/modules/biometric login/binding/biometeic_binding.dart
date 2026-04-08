import 'package:get/get.dart';
import 'package:laundry/modules/biometric%20login/controller/biometric_setting_controller.dart';

class BiometricBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiometricSettingController>(
      () => BiometricSettingController(),
    );
  }
}