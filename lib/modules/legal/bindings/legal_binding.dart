import 'package:get/get.dart';
import '../controllers/privacy_policy_controller.dart';
import '../controllers/terms_conditions_controller.dart';

class LegalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(() => PrivacyPolicyController());
    Get.lazyPut<TermsConditionsController>(() => TermsConditionsController());
  }
}
