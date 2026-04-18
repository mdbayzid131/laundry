import 'package:get/get.dart';
import 'package:laundry/config/constants/api_constants.dart';
import 'package:laundry/config/constants/storage_constants.dart';
import 'package:laundry/core/services/storage_service.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/modules/notifications/controllers/notifications_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
  IO.Socket? _socket;
  
  IO.Socket? get socket => _socket;

  @override
  void onInit() {
    super.onInit();
    _initSocket();
  }

  Future<void> _initSocket() async {
    final token = await StorageService.getString(StorageConstants.bearerToken);
    final userId = await StorageService.getString(StorageConstants.userId);

    Helpers.showDebugLog('🔍 Initializing Socket... Token length: ${token.length}, UserId: $userId', isError: false);
    
    if (token.isEmpty) {
      Helpers.showDebugLog('⚠️ Socket initialization skipped: No token found');
      return;
    }



    // Extract base URL from ApiConstants (remove /api/v1)
    String baseUrl = ApiConstants.baseUrl.replaceAll('/api/v1', '');
    Helpers.showDebugLog('🌐 Socket Base URL: $baseUrl', isError: false);

    _socket = IO.io(baseUrl, IO.OptionBuilder()
      .setTransports(['websocket'])
      .setAuth({'token': token})
      .enableAutoConnect()
      .enableForceNew() // Force a new connection
      .build());

    _socket?.onConnect((_) {
      Helpers.showDebugLog('✅ Socket connected successfully', isError: false);
      if (userId.isNotEmpty) {
        registerUser(userId);
      }
    });

    _socket?.on('new-notification', (data) {
      Helpers.showDebugLog('🔔 New notification received: $data', isError: false);
      
      // Update notifications list and unread count in real-time
      try {
        if (Get.isRegistered<NotificationsController>()) {
          Get.find<NotificationsController>().addNewNotification(data);
        }
      } catch (e) {
        Helpers.showDebugLog('Error adding to notifications list: $e');
      }

      Helpers.showCustomSnackBar(
        data['message'] ?? 'You have a new notification',
        isError: false,
      );
    });

    _socket?.onDisconnect((_) => Helpers.showDebugLog('🔌 Socket disconnected', isError: false));
    _socket?.onConnectError((err) => Helpers.showDebugLog('❌ Socket connect error: $err'));
    _socket?.onError((err) => Helpers.showDebugLog('❌ Socket error: $err'));
  }

  void connect() {
    if (_socket == null) {
      _initSocket();
    } else if (!_socket!.connected) {
      Helpers.showDebugLog('🔄 Manually connecting socket...', isError: false);
      _socket?.connect();
    }
  }

  void registerUser(String userId) {
    if (_socket != null && _socket!.connected) {
      _socket?.emit('register', userId);
      Helpers.showDebugLog('User registered with socket: $userId', isError: false);
    } else {
      Helpers.showDebugLog('Cannot register user: Socket not connected');
    }
  }

  void joinTicketRoom(String roomId) {
    _socket?.emit('join-room', roomId);
    Helpers.showDebugLog('Joined ticket room: $roomId', isError: false);
  }

  void leaveTicketRoom(String roomId) {
    _socket?.emit('leave-room', roomId);
    Helpers.showDebugLog('Left ticket room: $roomId', isError: false);
  }



  void sendMessage(String roomId, String senderId, String content) {
    final payload = {
      'roomId': roomId,
      'senderId': senderId,
      'content': content,
    };
    
    if (_socket != null && _socket!.connected) {
      Helpers.showDebugLog('🚀 Sending message via socket: $payload');
      _socket?.emit('send-message', payload);
    } else {
      Helpers.showDebugLog('❌ Cannot send message: Socket is not connected');
    }
  }

  void disconnect() {
    _socket?.disconnect();
  }
}
