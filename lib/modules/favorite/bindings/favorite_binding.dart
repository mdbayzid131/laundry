import 'package:get/get.dart';
import 'package:laundry/data/repositories/favorites_repository.dart';
import '../controllers/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesRepository>(() => FavoritesRepository());
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }
}
