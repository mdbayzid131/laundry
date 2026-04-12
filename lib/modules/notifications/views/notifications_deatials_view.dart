import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:laundry/modules/notifications/controllers/notifications_controller.dart';
import '../../../data/models/notifications_model.dart';

class NotificationDetailsView extends GetView<NotificationsController> {
  final NotificationItem notification;

  const NotificationDetailsView({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              notification.title ?? notification.type ?? 'No Title',
              style: GoogleFonts.manrope(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xff1A2530),
              ),
            ),
            SizedBox(height: 2.h),

            // Date
            Text(
              _formatDate(notification.createdAt),
              style: GoogleFonts.manrope(
                fontSize: 15.sp,
                color: Colors.black45,
              ),
            ),

            SizedBox(height: 2.h),

            // Description
            Text(
              notification.message ?? 'No description available',
              style: GoogleFonts.manrope(
                fontSize: 12.sp,
                color: const Color(0xff1A2530),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
