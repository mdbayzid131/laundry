import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:laundry/config/constants/api_constants.dart';
import 'package:laundry/core/services/api_client.dart';

class ContactSupportRepository {
  final ApiClient _apiClient = Get.find<ApiClient>();

  Future<Response> sendSupportEmail(Map<String, dynamic> body) async {
    return await _apiClient.postData(
      ApiConstants.emailSupport,
      body,
    );
  }
}
