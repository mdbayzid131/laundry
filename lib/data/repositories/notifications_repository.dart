import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:laundry/config/constants/api_constants.dart';
import 'package:laundry/core/services/api_client.dart';

class NotificationsRepository {
  final ApiClient _apiClient = Get.find<ApiClient>();

  Future<Response> getMyNotifications({int page = 1, int limit = 10}) async {
    return await _apiClient.getData(
      ApiConstants.myNotifications,
      query: {'page': page, 'limit': limit},
    );
  }

  Future<Response> markAllRead() async {
    return await _apiClient.patchData(ApiConstants.markAllRead, {});
  }

  Future<Response> markSingleAsRead(String id) async {
    return await _apiClient.patchData(
      ApiConstants.markSingleRead.replaceAll(':notificationId', id),
      {},
    );
  }
}
