

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:laundry/core/controllers/internet_controller.dart';
import 'package:laundry/core/services/api_client.dart';
import 'package:laundry/core/services/auth_service.dart';
import 'package:laundry/core/services/connectivity_service.dart';
import 'package:laundry/core/services/storage_service.dart';
import 'package:laundry/data/repositories/user_repository.dart';
import 'package:laundry/data/repositories/category_repository.dart';
import 'package:laundry/data/repositories/banner_repository.dart';
import 'package:laundry/data/repositories/service_repository.dart';
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize core services
    // Initialize core services
    Get.put(StorageService(), permanent: true);
    Get.put(ApiClient(), permanent: true);
    Get.put(AuthService(), permanent: true);

    Get.put(UserRepository(), permanent: true);
    Get.put(CategoryRepository(), permanent: true);
    Get.put(BannerRepository(), permanent: true);
    Get.put(ServiceRepository(), permanent: true);
    // Global controllers
    Get.put(InternetController(), permanent: true);

    // Services init
    ConnectivityService.init();
  }
}
