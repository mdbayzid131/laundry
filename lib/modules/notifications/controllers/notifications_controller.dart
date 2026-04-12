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
        }
      } 
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    }
  }
}
