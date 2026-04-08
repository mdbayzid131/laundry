import 'package:dio/src/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:laundry/config/constants/api_constants.dart';
import 'package:laundry/core/services/api_client.dart';

class CategoryRepository {
  final ApiClient _apiClient = Get.find();

  Future<Response> getCategories() async {
    return await _apiClient.getData(ApiConstants.category);
  }
}