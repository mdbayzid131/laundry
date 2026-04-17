import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/constants/storage_constants.dart';
import 'package:laundry/core/services/socket_service.dart';
import 'package:laundry/core/services/storage_service.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/repositories/support_ticket_repository.dart';
import 'package:laundry/modules/profile/controllers/profile_controller.dart';

class SupportTicketChatController extends GetxController {
  final SocketService _socketService = Get.find<SocketService>();
  final SupportTicketRepository _repository = Get.find<SupportTicketRepository>();
  
  final RxList<SupportChatMessage> messages = <SupportChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final textController = TextEditingController();
  final scrollController = ScrollController();
  
  late String roomId;
  late String ticketId;
  String? ticketNumber;
  String? userId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    roomId = args['roomId'];
    ticketId = args['ticketId'];
    ticketNumber = args['ticketNumber'];
    
    _initChat();
    getChatMessages();
  }

  Future<void> _initChat() async {
    await _initUserId();
    
    // Ensure socket is connected
    _socketService.connect();
    
    if (userId != null && userId!.isNotEmpty) {
      _socketService.registerUser(userId!);
    }
    
    // Join the room
    _socketService.joinTicketRoom(roomId);
    
    // Listen for new messages
    _socketService.socket?.on('new-message', (data) {
      if (data['roomId'] == roomId) {
        final newMessage = SupportChatMessage.fromJson(data);
        
        // Check if message already exists (to avoid duplicates from optimistic update)
        final exists = messages.any((msg) => msg.id == newMessage.id || 
            (msg.content == newMessage.content && msg.senderId == newMessage.senderId && 
             DateTime.now().difference(msg.createdAt ?? DateTime.now()).inSeconds < 5));
        
        if (!exists) {
          messages.add(newMessage);
          _scrollToBottom();
        }
      }
    });
  }

  Future<void> getChatMessages() async {
    isLoading.value = true;
    try {
      final response = await _repository.getChatRoomMessages(roomId);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final List<SupportChatMessage> fetchedMessages = data
            .map((json) => SupportChatMessage.fromJson(json))
            .toList();
        
        // Sort messages by time to ensure correct order
        fetchedMessages.sort((a, b) => (a.createdAt ?? DateTime.now())
            .compareTo(b.createdAt ?? DateTime.now()));
            
        messages.assignAll(fetchedMessages);
        _scrollToBottom();
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching chat messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void sendMessage() {
    final content = textController.text.trim();
    if (content.isEmpty) {
      Helpers.showDebugLog('⚠️ Message content is empty, not sending.');
      return;
    }
    
    if (userId == null || userId!.isEmpty) {
      Helpers.showDebugLog('❌ Cannot send message: userId is null or empty. Trying to re-fetch.');
      _initUserId();
      return;
    }
    
    Helpers.showDebugLog('💬 Attempting to send message: $content', isError: false);
    
    // Optimistic Update: Add message to UI immediately
    final optimisticMessage = SupportChatMessage(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      content: content,
      senderId: userId,
      roomId: roomId,
      createdAt: DateTime.now(),
    );
    messages.add(optimisticMessage);
    _scrollToBottom();
    
    Helpers.showDebugLog('📤 Calling socketService.sendMessage for roomId: $roomId', isError: false);
    _socketService.sendMessage(roomId, userId!, content);
    
    textController.clear();
  }

  Future<void> _initUserId() async {
    userId = await StorageService.getString(StorageConstants.userId);
    if (userId == null || userId!.isEmpty) {
      // If still empty, try to get from ProfileController
      try {
        final profileController = Get.find<ProfileController>();
        userId = profileController.userData.value?.id;
        if (userId != null) {
          StorageService.setString(StorageConstants.userId, userId!);
        }
      } catch (e) {
        Helpers.showDebugLog('ProfileController not found');
      }
    }
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    _socketService.leaveTicketRoom(roomId);
    _socketService.socket?.off('new-message');
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

class SupportChatMessage {
  final String? id;
  final String? content;
  final String? senderId;
  final String? roomId;
  final DateTime? createdAt;

  SupportChatMessage({
    this.id,
    this.content,
    this.senderId,
    this.roomId,
    this.createdAt,
  });

  factory SupportChatMessage.fromJson(Map<String, dynamic> json) {
    return SupportChatMessage(
      id: json['id'],
      content: json['content'],
      senderId: json['senderId'] ?? json['senderUserId'],
      roomId: json['roomId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}
