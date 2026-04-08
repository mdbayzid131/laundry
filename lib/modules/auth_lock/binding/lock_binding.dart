import 'package:get/get.dart';
import 'package:laundry/modules/auth_lock/controller/lock_controller.dart';

class LockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LockController>(() => LockController());
  }
}