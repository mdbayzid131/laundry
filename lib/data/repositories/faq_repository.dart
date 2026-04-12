import 'package:dio/dio.dart';
import 'package:laundry/config/constants/api_constants.dart';
import 'package:laundry/core/services/api_client.dart';
import 'package:get/get.dart' hide Response;

class FaqRepository {
  final ApiClient apiClient = Get.find<ApiClient>();

  Future<Response> getFaqs() async {
    return await apiClient.getData(
      ApiConstants.faq,
      query: {'page': 1, 'limit': 1000},
    );
  }
}
