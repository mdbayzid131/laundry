import 'package:get/get.dart';
import 'package:laundry/data/repositories/notifications_repository.dart';
import '../controllers/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsRepository>(() => NotificationsRepository());
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}
