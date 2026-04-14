import 'package:get/get.dart';
import 'package:laundry/modules/my_issues/controllers/my_issues_controller.dart';

class MyIssuesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyIssuesController>(() => MyIssuesController());
  }
}
