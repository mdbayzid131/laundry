import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:laundry/data/models/order_model.dart';
import 'package:laundry/config/routes/app_pages.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Order History',
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
      ),
      body: Column(
        children: [
          SizedBox(height: 16.h),
          _buildTabs(),
          SizedBox(height: 20.h),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.allOrders.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredOrders.isEmpty) {
                return Center(
                  child: Text(
                    'No orders found',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      color: Colors.black54,
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchOrders(),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount:
                      controller.filteredOrders.length +
                      (controller.hasMoreData.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.filteredOrders.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: _buildLoadMoreButton(),
                      );
                    }
                    final order = controller.filteredOrders[index];
                    return _buildOrderCard(order);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: controller.tabs.length,
        itemBuilder: (context, index) {
          final tab = controller.tabs[index];
          return Obx(() {
            final isSelected = controller.selectedTab.value == tab;
            return GestureDetector(
              onTap: () => controller.changeTab(tab),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xffB5DEEF) : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.black12,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    tab,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    Color statusColor;
    final status = order.status?.toUpperCase() ?? '';
    switch (status) {
      case 'PENDING':
        statusColor = Colors.orange;
        break;
      case 'PICKED_UP':
        statusColor = Colors.blue;
        break;
      case 'PROCESSING':
        statusColor = Colors.purple;
        break;
      case 'READY_FOR_DELIVERY':
        statusColor = Colors.cyan;
        break;
      case 'COMPLETED':
        statusColor = Colors.green;
        break;
      case 'CANCELLED':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    final firstItem = order.orderItems?.isNotEmpty == true
        ? order.orderItems!.first
        : null;
    final serviceName = firstItem?.serviceName ?? 'No Service';
    final itemsCount = order.orderItems?.length ?? 0;

    String formattedDate = '';
    if (order.createdAt != null) {
      try {
        final date = DateTime.parse(order.createdAt!);
        formattedDate = DateFormat('MMM dd, yyyy • h:mm a').format(date);
      } catch (e) {
        formattedDate = order.createdAt!;
      }
    }

    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${order.orderNumber}',
                style: GoogleFonts.manrope(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
              Text(
                status,
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            formattedDate,
            style: GoogleFonts.manrope(fontSize: 12.sp, color: Colors.black45),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xffF9F9F9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: SvgPicture.asset(
                  _getIconForService(serviceName),
                  colorFilter: const ColorFilter.mode(
                    Color(0xff1A2530),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff1A2530),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '$itemsCount items • ${order.isSubscription == true ? ' Express delivery' : ' Regular delivery'}',
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(height: 1, color: Color(0xffF1F5F9)),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${order.totalAmount ?? '0.00'}',
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: status == 'CANCELLED'
                      ? Colors.grey.shade400
                      : const Color(0xff1A2530),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.TRACK_ORDER, arguments: order),
                child: Text(
                  'View Details',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getIconForService(String serviceType) {
    final lower = serviceType.toLowerCase();
    if (lower.contains('wash')) return ImagePaths.shirtIcon;
    if (lower.contains('dry')) return ImagePaths.dryCleanIcon;
    return ImagePaths.ironAndPressIcon;
  }

  Widget _buildLoadMoreButton() {
    return Obx(() {
      if (controller.isLoadingMore.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return GestureDetector(
        onTap: () => controller.fetchOrders(isLoadMore: true),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.black12),
            ),
            child: Text(
              'Load More Orders',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      );
    });
  }
}
