import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../core/services/api_client.dart';
import '../../config/constants/api_constants.dart';

class CartRepository {
  final ApiClient _apiClient = Get.find();

  Future<Response> addToCart({
    String? storeServiceId,
    String? storeBundleId,
    required int quantity,
    List<String>? addonIds,
  }) async {
    Map<String, dynamic> body = {'quantity': quantity};

    if (storeBundleId != null && storeBundleId.isNotEmpty) {
      body['storeBundleId'] = storeBundleId;
    } else {
      body['storeServiceId'] = storeServiceId;
      body['addonIds'] = addonIds ?? [];
    }

    return await _apiClient.postData(
      ApiConstants.addToCart,
      body,
    );
  }

  Future<Response> getMyCart() async {
    return await _apiClient.getData(ApiConstants.getMyCart);
  }

  Future<Response> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    return await _apiClient.patchData(
      ApiConstants.updateCartQuantity.replaceAll(':cartItemId', cartItemId),
      {'quantity': quantity},
    );
  }

  Future<Response> deleteCartItem(String cartItemId) async {
    return await _apiClient.deleteData(
      ApiConstants.deleteCartItem.replaceAll(':cartItemId', cartItemId),
    );
  }
}
