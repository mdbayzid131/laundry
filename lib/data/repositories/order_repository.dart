import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../core/services/api_client.dart';
import '../../config/constants/api_constants.dart';

class OrderRepository {
  final ApiClient _apiClient = Get.find<ApiClient>();

  Future<Response> checkout(Map<String, dynamic> body) async {
    return await _apiClient.postData(
      ApiConstants.checkout,
      body,
    );
  }

  Future<Response> getMyOrders({int page = 1, int limit = 10, bool? pastOrders}) async {
    final Map<String, dynamic> query = {'page': page, 'limit': limit};
    if (pastOrders != null) {
      query['pastOrders'] = pastOrders;
    }
    return await _apiClient.getData(
      ApiConstants.myOrders,
      query: query,
    );
  }

  Future<Response> getActiveOrders() async {
    return await _apiClient.getData(
      ApiConstants.activeOrders,
    );
  }

  Future<Response> getOrderDetails(String orderId) async {
    return await _apiClient.getData(
      '${ApiConstants.orderDetail}$orderId',
    );
  }

  Future<Response> submitOrderIssue(String orderId, String issueTitle, String description, {String? imagePath}) async {
    final body = {
      'orderId': orderId,
      'issueTitle': issueTitle,
      'description': description,
    };
    
    if (imagePath != null && imagePath.isNotEmpty) {
      return await _apiClient.postMultipartData(
        ApiConstants.orderIssue,
        body,
        multipartBody: [
          MultipartBody('image', File(imagePath))
        ]
      );
    } else {
      return await _apiClient.postData(
        ApiConstants.orderIssue,
        body,
      );
    }
  }

  Future<Response> getMyOrderIssues({int page = 1, int limit = 10}) async {
    return await _apiClient.getData(
      ApiConstants.orderIssue,
      query: {'page': page, 'limit': limit},
    );
  }

  Future<Response> getOrderIssueDetails(String issueId) async {
    return await _apiClient.getData(
      '${ApiConstants.orderIssue}/$issueId',
    );
  }
}
