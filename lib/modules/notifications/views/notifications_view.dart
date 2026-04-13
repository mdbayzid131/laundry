import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:laundry/data/models/notifications_model.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notifications',
              style: GoogleFonts.manrope(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xff1A2530),
              ),
            ),
            GestureDetector(
              onTap: () => controller.markAllNotificationsRead(),
              child: Text(
                'Mark All Read',
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Center(
            child: Container(
              height: 40.w,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18.sp,
                  color: Colors.black87,
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => controller.getNotifications(),
            child: ListView(
              children: [
                SizedBox(height: Get.height * 0.3),
                Center(
                  child: Text(
                    'No notifications found',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.getNotifications(),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            itemCount:
                controller.notifications.length +
                (controller.hasMoreData.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.notifications.length) {
                return _buildLoadMoreIndicator();
              }
              final NotificationItem notification =
                  controller.notifications[index];
              return _buildNotificationCard(notification);
            },
          ),
        );
      }),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Obx(() {
      if (controller.isLoadingMore.value) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: const Center(child: CircularProgressIndicator()),
        );
      }
      return GestureDetector(
        onTap: () => controller.getNotifications(isLoadMore: true),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Center(
            child: Text(
              'Load More',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black45,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    String timeAgo = '';
    if (notification.createdAt != null) {
      try {
        final date = DateTime.parse(notification.createdAt!);
        timeAgo = DateFormat('MMM dd, h:mm a').format(date);
      } catch (e) {
        timeAgo = notification.createdAt!;
      }
    }

    final bool isRead = notification.isRead ?? false;

    return GestureDetector(
      onTap: () {
        if (notification.id != null) {
          controller.markAsRead(notification.id!);
        }
        Get.toNamed(AppRoutes.NOTIFICATION_DETAILS, arguments: notification);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xffF9F9F9),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black.withOpacity(0.03)),
              ),
              child: Icon(
                _getIconForType(notification.type),
                size: 24.sp,
                color: const Color(0xff1A2530),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title ?? '',
                          style: GoogleFonts.manrope(
                            fontSize: 15.sp,
                            fontWeight: isRead ? FontWeight.normal : FontWeight.w700,
                            color: const Color(0xff1A2530),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        timeAgo,
                        style: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          color: Colors.black38,
                          fontWeight: isRead ? FontWeight.normal : FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    notification.message ?? '',
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      color: Colors.black54,
                      fontWeight: isRead ? FontWeight.normal : FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    notification.type?.replaceAll('_', ' ') ?? 'Update',
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      fontWeight: isRead ? FontWeight.normal : FontWeight.w700,
                      color: _getColorForType(notification.type),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(String? type) {
    switch (type) {
      case 'ORDER_UPDATE':
        return Icons.inventory_2_outlined;
      case 'PROMOTION':
        return Icons.percent;
      case 'SYSTEM_ALERT':
        return Icons.notifications_none;
      default:
        return Icons.notifications_active_outlined;
    }
  }

  Color _getColorForType(String? type) {
    switch (type) {
      case 'ORDER_UPDATE':
        return const Color(0xff4A90E2);
      case 'PROMOTION':
        return const Color(0xff10B981);
      case 'SYSTEM_ALERT':
        return Colors.orange;
      default:
        return Colors.black45;
    }
  }
}
