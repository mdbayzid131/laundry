

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
import 'package:laundry/data/repositories/address_repository.dart';
import 'package:laundry/data/repositories/cart_repository.dart';
import 'package:laundry/data/repositories/order_repository.dart';
import 'package:laundry/data/repositories/store_repository.dart';
import 'package:laundry/data/repositories/favorites_repository.dart';
import 'package:laundry/modules/favorite/controllers/favorite_controller.dart';

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
    Get.put(AddressRepository(), permanent: true);
    Get.put(CartRepository(), permanent: true);
    Get.put(OrderRepository(), permanent: true);
    Get.put(StoreRepository(), permanent: true);
    Get.put(FavoritesRepository(), permanent: true);

    // Global controllers
    Get.put(InternetController(), permanent: true);
    Get.lazyPut(() => FavoriteController(), fenix: true);

    // Services init
    ConnectivityService.init();
  }
}
