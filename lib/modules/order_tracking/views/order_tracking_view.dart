import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:laundry/config/routes/app_pages.dart';

import 'package:laundry/modules/order_tracking/controllers/order_tracking_controller.dart';
import 'package:laundry/data/models/active_order_model.dart';

class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderTrackingController controller = Get.find<OrderTrackingController>();
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final order = controller.order.value;
        if (order == null) {
          return const Center(child: Text('Order not found'));
        }

        return Column(
          children: [
            // Map Section
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Stack(
                children: [
                  // Google Map
                  GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(45.5152, -122.6784),
                      zoom: 14,
                    ),
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                  ),
                  // Map center marker (car)
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  // Top Action Buttons
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCircleButton(
                            Icons.close,
                            onTap: () => Get.back(),
                          ),
                          Column(
                            children: [
                              _buildCircleButton(Icons.question_mark),
                              SizedBox(height: 12.h),
                              _buildCircleButton(Icons.location_on),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Overlay Progress Bar on Map
                  Positioned(
                    bottom: 40.h,
                    left: 30.w,
                    right: 30.w,
                    child: _buildMapOverlayProgressBar(order),
                  ),
                ],
              ),
            ),
            // Details Section
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.activeOrderMetadata?.statusMessage ?? 'Order Status',
                      style: GoogleFonts.manrope(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xff1A2530),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Now arriving by: ${order.activeOrderMetadata?.estimatedArrivalTime ?? 'N/A'}',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    // Timeline
                    _buildTimeline(order),
                    SizedBox(height: 32.h),
                    // Driver Info
                    _buildDriverInfo(order.activeOrderMetadata?.driver),
                    const Spacer(),
                    // Show Order Details Button
                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (order.id != null) {
                            Get.toNamed(AppRoutes.TRACK_ORDER, arguments: order.id);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffA6D4E9),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Show order details',
                          style: GoogleFonts.manrope(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCircleButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20.sp, color: Colors.black87),
      ),
    );
  }

  Widget _buildMapOverlayProgressBar(ActiveOrder order) {
    final currentStep = order.activeOrderMetadata?.currentStep ?? 0;
    final totalSteps = order.activeOrderMetadata?.totalSteps ?? 4;
    final progress = (currentStep / totalSteps).clamp(0.0, 1.0);

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Background line
        Container(
          height: 6.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xff57606F),
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        // Active line
        LayoutBuilder(
          builder: (context, constraints) {
            return Positioned(
              left: 0,
              child: Container(
                height: 6.h,
                width: constraints.maxWidth * progress,
                decoration: BoxDecoration(
                  color: const Color(0xff15803D), // Darker green
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            );
          },
        ),
        // Store Icon
        Positioned(
          left: 60.w,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xff15803D), // Darker green
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.storefront, color: Colors.white, size: 24.sp),
          ),
        ),
        // Home Icon
        Positioned(
          right: 30.w,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: currentStep >= totalSteps ? const Color(0xff15803D) : const Color(0xff4B5563),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.home, color: Colors.white, size: 24.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(ActiveOrder order) {
    final currentStep = order.activeOrderMetadata?.currentStep ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTimelineNode(Icons.storefront, isActive: currentStep >= 1),
        _buildTimelineLine(isActive: currentStep >= 2),
        _buildTimelineNode(Icons.person, isActive: currentStep >= 2),
        _buildTimelineLine(isActive: currentStep >= 3),
        _buildTimelineNode(Icons.directions_car, isActive: currentStep >= 3),
        _buildTimelineLine(isActive: currentStep >= 4),
        _buildTimelineNode(Icons.home, isActive: currentStep >= 4),
      ],
    );
  }

  Widget _buildTimelineNode(IconData icon, {required bool isActive}) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xffA6D4E9) : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 16.sp),
    );
  }

  Widget _buildTimelineLine({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 2.h,
        color: isActive ? const Color(0xffA6D4E9) : Colors.grey[300],
      ),
    );
  }

  Widget _buildDriverInfo(Driver? driver) {
    if (driver == null) return const SizedBox();
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: driver.avatar != null && driver.avatar!.isNotEmpty
                        ? NetworkImage(driver.avatar!) as ImageProvider
                        : const AssetImage('assets/dummy_image/op1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.name ?? 'Unknown',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14.sp, color: Colors.black87),
                      SizedBox(width: 4.w),
                      Text(
                        driver.rating?.toString() ?? '0.0',
                        style: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // _buildActionPill('Add tip', icon: null),
              _buildActionPill(
                'Call ${driver.phone ?? ''}',
                icon: Icons.call,
                onTap: () async {
                  if (driver.phone != null && driver.phone!.isNotEmpty) {
                    final Uri launchUri = Uri(
                      scheme: 'tel',
                      path: driver.phone,
                    );
                    await launchUrl(launchUri);
                  }
                },
              ),
              // _buildActionPill('Chat', icon: Icons.chat_bubble_outline),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionPill(String text, {IconData? icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16.sp, color: Colors.black87),
              SizedBox(width: 6.w),
            ],
            Text(
              text,
              style: GoogleFonts.manrope(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
