import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/constants/image_paths.dart';
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
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: controller.filteredOrders.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.filteredOrders.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: _buildLoadMoreButton(),
                    );
                  }
                  final order = controller.filteredOrders[index];
                  return _buildOrderCard(order);
                },
              ),
            ),
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

  Widget _buildOrderCard(OrderModel order) {
    Color statusColor;
    switch (order.status) {
      case 'Completed':
        statusColor = const Color(0xff22C55E);
        break;
      case 'In Progress':
        statusColor = const Color(0xff3B82F6);
        break;
      case 'Cancelled':
        statusColor = const Color(0xffEF4444);
        break;
      default:
        statusColor = Colors.grey;
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
                'Order #${order.orderNo}',
                style: GoogleFonts.manrope(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
              Text(
                order.status,
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
            order.date,
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
                  _getIconForService(order.serviceType),
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
                      order.serviceType,
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff1A2530),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${order.itemsCount} items • ${order.deliveryType}',
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
          Text(
            '\$${order.price.toStringAsFixed(2)}',
            style: GoogleFonts.manrope(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: order.status == 'Cancelled'
                  ? Colors.grey.shade400
                  : const Color(0xff1A2530),
            ),
          ),
        ],
      ),
    );
  }

  String _getIconForService(String serviceType) {
    if (serviceType.contains('Wash')) return ImagePaths.shirtIcon;
    if (serviceType.contains('Dry')) return ImagePaths.dryCleanIcon;
    return ImagePaths.ironAndPressIcon;
  }

  Widget _buildLoadMoreButton() {
    return Center(
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
    );
  }
}
