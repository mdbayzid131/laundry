
import 'package:dio/src/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../core/services/api_client.dart';
import '../../config/constants/api_constants.dart';

class UserRepository {
  final ApiClient _apiClient = Get.find();

  // Get user profile
  Future<Response<dynamic>> getProfile() async {
    return await _apiClient.getData(ApiConstants.profile);
  }

  // Update user profile
  Future<Response> updateProfile({
    required String name,
    String? phone,
  }) async {
    return await _apiClient.putData(
      ApiConstants.updateProfile,
      {
        'name': name,
        'phone': phone,
      },
    );
  }
}
