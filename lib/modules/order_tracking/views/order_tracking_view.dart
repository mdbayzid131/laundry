import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/routes/app_pages.dart';

class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffF9F9F9),
        elevation: 0,
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
        title: Text(
          'Track Order',
          style: GoogleFonts.manrope(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff1A2530),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            _buildOrderInfoCard(),
            SizedBox(height: 24.h),
            _buildOrderProgress(),
            SizedBox(height: 24.h),
            _buildCurrentStatusCard(),
            SizedBox(height: 24.h),
            _buildNeedHelpCard(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #LN2024001',
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xffEAF5FB),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'In Process',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff4A90E2),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            'Placed on Jan 15, 2024',
            style: GoogleFonts.manrope(fontSize: 13.sp, color: Colors.black54),
          ),
          SizedBox(height: 20.h),
          _buildInfoRow('Service Type', 'Wash & Fold'),
          SizedBox(height: 12.h),
          _buildInfoRow('Items', '12 pieces'),
          SizedBox(height: 12.h),
          _buildInfoRow(
            'Estimated Delivery',
            'Today, 6:00 PM',
            valueColor: const Color(0xff4A90E2),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(fontSize: 14.sp, color: Colors.black54),
        ),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: valueColor ?? const Color(0xff1A2530),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderProgress() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Progress',
                style: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.PICKUP_ADDRESS),
                child: Text(
                  'Add Pickup Address',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.black45,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildTimelineStep(
            'Order Confirmed',
            'Jan 15, 10:30 AM',
            Icons.check,
            isCompleted: true,
            isLast: false,
          ),
          _buildTimelineStep(
            'Picked Up',
            'Jan 15, 2:15 PM',
            Icons.local_shipping,
            isCompleted: true,
            isLast: false,
          ),
          _buildTimelineStep(
            'In Process',
            'Your items are being cleaned',
            Icons.local_laundry_service,
            isCurrent: true,
            isLast: false,
          ),
          _buildTimelineStep(
            'Schedule pick up & delivery',
            '',
            Icons.access_time,
            isLast: false,
          ),
          _buildTimelineStep(
            'Out for Delivery',
            'Pending',
            Icons.delivery_dining,
            isLast: false,
          ),
          _buildTimelineStep('Delivered', 'Pending', Icons.home, isLast: true),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xffB5DEEF).withOpacity(0.6),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time, size: 18.sp, color: Colors.white),
                SizedBox(width: 8.w),
                Text(
                  'Schedule pick up & delivery',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    String title,
    String subtitle,
    IconData icon, {
    bool isCompleted = false,
    bool isCurrent = false,
    bool isLast = false,
  }) {
    final color = isCompleted || isCurrent
        ? const Color(0xffB5DEEF)
        : Colors.grey[300]!;
    final iconColor = isCompleted || isCurrent
        ? Colors.white
        : Colors.grey[400]!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, size: 16.sp, color: iconColor),
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 40.h,
                color: color.withOpacity(0.5),
              ),
          ],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 15.sp,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
                  color: isCurrent || isCompleted
                      ? const Color(0xff1A2530)
                      : Colors.grey[400],
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStatusCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xffEAF5FB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_filled, size: 16.sp, color: Colors.black),
              SizedBox(width: 8.w),
              Text(
                'Current Status',
                style: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Your laundry is currently being processed at our facility. Our team is carefully washing and treating your items according to your preferences. Estimated completion time is 2:00 PM.',
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeedHelpCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Need Help?',
                style: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Contact our support team',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.headset_mic_outlined,
              size: 24.sp,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
