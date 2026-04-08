import 'package:dio/src/response.dart';
import 'package:get/get.dart' hide Response;
import 'package:laundry/config/constants/api_constants.dart';
import 'package:laundry/core/services/api_client.dart';

class OrderRepository {
  final ApiClient apiClient = Get.find<ApiClient>();

  Future<Response<dynamic>> getMyOrders({int page = 1, int limit = 10}) async {
    return await apiClient.getData(
      ApiConstants.myOrders,
      query: {'page': page, 'limit': limit},
    );
  }
}
