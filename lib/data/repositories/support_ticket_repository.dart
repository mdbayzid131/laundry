import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:laundry/config/constants/api_constants.dart';
import 'package:laundry/core/services/api_client.dart';

class SupportTicketRepository {
  final ApiClient _apiClient = Get.find<ApiClient>();

  Future<Response> getSupportTickets() async {
    return await _apiClient.getData(
      ApiConstants.supportTicket,
    );
  }

  Future<Response> createSupportTicket(Map<String, dynamic> body) async {
    return await _apiClient.postData(
      ApiConstants.supportTicket,
      body,
    );
  }

  Future<Response> getTicketDetails(String id) async {
    return await _apiClient.getData(
      '${ApiConstants.supportTicket}/$id',
    );
  }

  Future<Response> getChatRoomMessages(String roomId) async {
    return await _apiClient.getData(
      ApiConstants.chatRoomMessages.replaceFirst(':roomId', roomId),
    );
  }
}
