import 'package:get/get.dart';
import 'package:laundry/modules/my_issues/controllers/issue_details_controller.dart';

class IssueDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IssueDetailsController>(() => IssueDetailsController());
  }
}
