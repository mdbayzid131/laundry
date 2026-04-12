import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:laundry/config/constants/api_constants.dart';
import 'package:laundry/core/services/api_client.dart';

class FavoritesRepository {
  final ApiClient _apiClient = Get.find<ApiClient>();

  Future<Response> getMyFavorites() async {
    return await _apiClient.getData(ApiConstants.myFavorites);
  }

  Future<Response> toggleFavorite(Map<String, dynamic> body) async {
    return await _apiClient.postData(ApiConstants.toggleFavorite, body);
  }
}
