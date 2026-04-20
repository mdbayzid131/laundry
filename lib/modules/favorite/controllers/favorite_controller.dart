import 'package:get/get.dart';
import 'package:laundry/core/services/api_checker.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/favorites_model.dart';
import 'package:laundry/data/repositories/cart_repository.dart';
import 'package:laundry/data/repositories/favorites_repository.dart';

class FavoriteController extends GetxController {
  final FavoritesRepository _repository = Get.find<FavoritesRepository>();
  final CartRepository _cartRepository = Get.find<CartRepository>();

  final RxList<FavoriteItem> favoriteItems = <FavoriteItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isAddingToCart = false.obs;

  @override
  void onInit() {
    super.onInit();
    getFavorites();
  }

  Future<void> getFavorites() async {
    isLoading.value = true;
    try {
      final response = await _repository.getMyFavorites();
      ApiChecker.checkGetApi(response);
      if (response.statusCode == 200) {
        final FavoritesModel favoritesModel = FavoritesModel.fromJson(
          response.data,
        );
        favoriteItems.value = favoritesModel.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart(FavoriteItem item) async {
    if (isAddingToCart.value) return;

    isAddingToCart.value = true;

    try {
      final response = await _cartRepository.addToCart(
        storeServiceId: item.storeServiceId,
        storeBundleId: item.storeBundleId,
        quantity: 1,
        addonIds: [],
      );

      ApiChecker.checkWriteApi(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helpers.showCustomSnackBar(
          response.data['message'] ?? 'Added to cart successfully',
          isError: false,
        );
      }
    } catch (e) {
      Helpers.showDebugLog('Error adding to cart from favorites: $e');
    } finally {
      isAddingToCart.value = false;
    }
  }

  Future<void> toggleFavorite(FavoriteItem item) async {
    // If it's already in favorites, we want to remove it.
    // The API structure usually expects the ID of the thing being toggled.
    // Based on the provided body logic in previous tasks, we send service info.

    Map<String, dynamic> body = {};
    if (item.storeServiceId != null) {
      body['storeServiceId'] = item.storeServiceId;
    } else if (item.serviceId != null) {
      body['serviceId'] = item.serviceId;
    } else if (item.storeBundleId != null) {
      body['storeBundleId'] = item.storeBundleId;
    }

    try {
      final response = await _repository.toggleFavorite(body);
       ApiChecker.checkWriteApi(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final message =
            response.data['data']?['message'] ?? response.data['message'];
        Helpers.showCustomSnackBar(message, isError: false);

        // Optimistically remove from list if status is REMOVED or simply refresh
        if (response.data['data']?['status'] == 'REMOVED') {
          favoriteItems.removeWhere((element) =>
              (item.storeServiceId != null &&
                  element.storeServiceId == item.storeServiceId) ||
              (item.serviceId != null && element.serviceId == item.serviceId) ||
              (item.storeBundleId != null &&
                  element.storeBundleId == item.storeBundleId));
        } else {
          getFavorites(); // Refresh to get the full data for the new favorite
        }
      } 
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    }
  }
}
