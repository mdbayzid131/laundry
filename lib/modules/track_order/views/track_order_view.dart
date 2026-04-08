import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:laundry/data/models/order_model.dart';
import '../controllers/track_order_controller.dart';

class TrackOrderView extends GetView<TrackOrderController> {
  const TrackOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: _buildAppBar(),
      body: Obx(() {
        final order = controller.order.value;
        if (order == null) {
          return const Center(child: Text('No order found'));
        }
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderSummary(order),
              SizedBox(height: 20.h),
              _buildOrderProgress(order),
              SizedBox(height: 20.h),
              _buildCurrentStatusCard(),
              SizedBox(height: 20.h),
              _buildHelpCard(),
              SizedBox(height: 30.h),
            ],
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Track Order',
        style: GoogleFonts.manrope(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xff1A2530),
        ),
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
    );
  }

  Widget _buildOrderSummary(Order order) {
    String formattedDate = '';
    if (order.createdAt != null) {
      try {
        final date = DateTime.parse(order.createdAt!);
        formattedDate = DateFormat('MMM dd, yyyy').format(date);
      } catch (e) {
        formattedDate = order.createdAt!;
      }
    }

    final status = order.status?.toUpperCase() ?? '';
    final serviceType = order.orderItems?.isNotEmpty == true
        ? order.orderItems!.first.serviceName ?? 'N/A'
        : 'N/A';
    final itemsCount = order.orderItems?.length ?? 0;

    return Container(
      padding: EdgeInsets.all(20.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${order.orderNumber}',
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xffE6F2FA),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2563EB),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            'Placed on $formattedDate',
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: Colors.black45,
            ),
          ),
          SizedBox(height: 20.h),
          _buildSummaryRow('Service Type', serviceType),
          SizedBox(height: 12.h),
          _buildSummaryRow('Items', '$itemsCount pieces'),
          SizedBox(height: 12.h),
          _buildSummaryRow(
            'Estimated Delivery',
            'Today, 6:00 PM',
            valueColor: const Color(0xff2563EB),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            color: Colors.black45,
          ),
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

  Widget _buildOrderProgress(Order order) {
    return Container(
      padding: EdgeInsets.all(20.w),
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
              Text(
                'Add Pickup Address',
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildStep(
            index: 0,
            title: 'Order Confirmed',
            time: 'Jan 15, 10:30 AM',
            icon: Icons.check,
            isLast: false,
          ),
          _buildStep(
            index: 1,
            title: 'Picked Up',
            time: 'Jan 15, 2:15 PM',
            icon: Icons.local_shipping_outlined,
            isLast: false,
          ),
          _buildStep(
            index: 2,
            title: 'In Process',
            subTitle: 'Your items are being cleaned',
            icon: Icons.sync,
            isLast: false,
          ),
          _buildStep(
            index: 3,
            title: 'Schedule pick up & delivery',
            icon: Icons.access_time,
            isLast: false,
          ),
          _buildStep(
            index: 4,
            title: 'Out for Delivery',
            subTitle: 'Pending',
            icon: Icons.delivery_dining_outlined,
            isLast: false,
          ),
          _buildStep(
            index: 5,
            title: 'Delivered',
            subTitle: 'Pending',
            icon: Icons.home_outlined,
            isLast: true,
          ),
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xffB5DEEF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time, color: Colors.white, size: 20.sp),
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

  Widget _buildStep({
    required int index,
    required String title,
    String? time,
    String? subTitle,
    required IconData icon,
    required bool isLast,
  }) {
    return Obx(() {
      final isActive = controller.currentStep.value >= index;
      
      return SizedBox(
        height: 75.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xffB5DEEF) : const Color(0xffE5E7EB),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.w,
                      color: controller.currentStep.value > index 
                          ? const Color(0xffB5DEEF) 
                          : const Color(0xffE5E7EB),
                    ),
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
                      fontWeight: FontWeight.w700,
                      color: isActive ? const Color(0xff1A2530) : Colors.black45,
                    ),
                  ),
                  if (time != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      time,
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                  if (subTitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subTitle,
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCurrentStatusCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xffE6F2FA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_filled, size: 18.sp, color: Colors.black),
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
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
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
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xffF9F9F9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.headset_mic_outlined,
              color: const Color(0xff1A2530),
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
