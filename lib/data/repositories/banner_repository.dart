import 'package:dio/dio.dart';
import '../../core/services/api_client.dart';
import '../../config/constants/api_constants.dart';
import 'package:get/get.dart' hide Response;

class BannerRepository {
  final ApiClient _apiClient = Get.find();

  Future<Response> getBanners() async {
    return await _apiClient.getData(ApiConstants.banner);
  }

  Future<Response> getAds(double lat, double lng) async {
    return await _apiClient.getData(
      ApiConstants.ads,
      query: {
        'userLat': lat,
        'userLng': lng,
      },
    );
  }
}
