import 'package:flutter/material.dart' show Navigator;
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/support_ticket_model.dart';
import 'package:laundry/data/repositories/support_ticket_repository.dart';

class SupportTicketController extends GetxController {
  final SupportTicketRepository _repository = Get.find<SupportTicketRepository>();

  final RxBool isLoading = false.obs;
  final RxList<SupportTicket> tickets = <SupportTicket>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTickets();
  }

  Future<void> getTickets() async {
    isLoading.value = true;
    try {
      final response = await _repository.getSupportTickets();
      if (response.statusCode == 200) {
        final ticketResponse = SupportTicketResponse.fromJson(response.data);
        tickets.assignAll(ticketResponse.data ?? []);
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching tickets: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTicket(String subject, String description) async {
    isLoading.value = true;
    
    try {
      final response = await _repository.createSupportTicket({
        'subject': subject,
        'description': description,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helpers.showCustomSnackBar('Ticket created successfully', isError: false);
        Navigator.pop(Get.context!); // Close create ticket dialog/page
        getTickets(); // Refresh list
      }
    } catch (e) {
      Helpers.showDebugLog('Error creating ticket: $e');
      Helpers.showCustomSnackBar('Failed to create ticket', isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
