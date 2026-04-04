import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response; // Hide GetX Response
import '../../core/services/api_client.dart';
import '../../config/constants/api_constants.dart';

class ServiceRepository {
  final ApiClient _apiClient = Get.find();

  Future<Response> getServices() async {
    return await _apiClient.getData(ApiConstants.service);
  }

  Future<Response> getServiceDetails(String id) async {
    return await _apiClient.getData('${ApiConstants.service}/$id');
  }
}
