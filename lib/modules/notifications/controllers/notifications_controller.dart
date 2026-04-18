import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:laundry/core/services/api_checker.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/notifications_model.dart';
import 'package:laundry/data/repositories/notifications_repository.dart';

class NotificationsController extends GetxController {
  final NotificationsRepository _repository =
      Get.find<NotificationsRepository>();

  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMoreData = true.obs;
  final RxInt currentPage = 1.obs;
  final RxInt unreadCount = 0.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  Future<void> getNotifications({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoadingMore.value || !hasMoreData.value) return;
      isLoadingMore.value = true;
      currentPage.value++;
    } else {
      isLoading.value = true;
      currentPage.value = 1;
      notifications.clear();
      hasMoreData.value = true;
    }

    try {
      final response = await _repository.getMyNotifications(
        page: currentPage.value,
        limit: limit,
      );

      if (response.statusCode == 200) {
        ApiChecker.checkGetApi(response);
        final NotificationModel model = NotificationModel.fromJson(
          response.data,
        );
        final List<NotificationItem> newItems = model.data ?? [];

        if (newItems.length < limit) {
          hasMoreData.value = false;
        }

        notifications.addAll(newItems);
        _updateUnreadCount();
      }
    } catch (e) {
      Helpers.showDebugLog(e.toString());
      // Error handling
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> markAllNotificationsRead() async {
    try {
      final response = await _repository.markAllRead();
      ApiChecker.checkWriteApi(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final message =
            response.data['message'] ?? 'All notifications marked as read';
        Helpers.showCustomSnackBar(message, isError: false);

        // Refresh notifications to show as read
        getNotifications();
      }
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      final response = await _repository.markSingleAsRead(id);
       ApiChecker.checkWriteApi(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Update local state
        final index = notifications.indexWhere((element) => element.id == id);
        if (index != -1) {
          final item = notifications[index];
          notifications[index] = NotificationItem(
            id: item.id,
            userId: item.userId,
            operatorId: item.operatorId,
            title: item.title,
            message: item.message,
            channel: item.channel,
            type: item.type,
            isSent: item.isSent,
            isRead: true,
            createdAt: item.createdAt,
          );
          _updateUnreadCount();
        }
      } 
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    }
  }

  void _updateUnreadCount() {
    unreadCount.value =
        notifications.where((element) => element.isRead == false).length;
  }

  void addNewNotification(Map<String, dynamic> data) {
    try {
      final NotificationItem newItem = NotificationItem.fromJson(data);
      // Check if it's already in the list to avoid duplicates
      if (!notifications.any((element) => element.id == newItem.id)) {
        notifications.insert(0, newItem);
        _updateUnreadCount();
      }
    } catch (e) {
      // Fallback if data is not a full NotificationItem object
      final newItem = NotificationItem(
        id: data['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: data['title'] ?? 'New Notification',
        message: data['message'] ?? '',
        type: data['type'] ?? 'UPDATE',
        createdAt: data['createdAt'] ?? DateTime.now().toIso8601String(),
        isRead: false,
      );
      notifications.insert(0, newItem);
      _updateUnreadCount();
    }
  }
}
