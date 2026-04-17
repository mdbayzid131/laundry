import 'package:get/get.dart';
import '../controllers/support_ticket_controller.dart';
import '../controllers/support_ticket_chat_controller.dart';

class SupportTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportTicketController>(() => SupportTicketController());
    Get.lazyPut<SupportTicketChatController>(() => SupportTicketChatController());
  }
}
