import 'package:dio/dio.dart';
import 'package:laundry/config/constants/api_constants.dart';
import 'package:laundry/core/services/api_client.dart';
import 'package:get/get.dart' hide Response;
import 'package:laundry/data/models/phone_support_model.dart';

class PhoneSupportRepository {
  final ApiClient apiClient = Get.find<ApiClient>();

  Future<Response> getPhoneSupport() async {
    return await apiClient.getData(ApiConstants.phoneSupport);
  }
}
