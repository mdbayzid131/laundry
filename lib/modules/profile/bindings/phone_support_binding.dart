import 'package:get/get.dart';
import 'package:laundry/data/repositories/phone_support_repository.dart';
import 'package:laundry/modules/profile/controllers/phone_support_controller.dart';

class PhoneSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneSupportRepository>(() => PhoneSupportRepository());
    Get.lazyPut<PhoneSupportController>(() => PhoneSupportController());
  }
}
