import 'package:get/get.dart';
import 'package:laundry/data/repositories/contract_support_repository.dart';
import 'package:laundry/modules/profile/controllers/contact_support_controller.dart';
import 'package:laundry/modules/profile/controllers/help_support_controller.dart';

class HelpSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactSupportRepository>(() => ContactSupportRepository());
    Get.lazyPut<HelpSupportController>(() => HelpSupportController());
    Get.lazyPut<ContactSupportController>(() => ContactSupportController());
  }
}