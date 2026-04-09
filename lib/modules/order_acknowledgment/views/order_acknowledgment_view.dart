import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/routes/app_pages.dart';
import '../controllers/order_acknowledgment_controller.dart';

class OrderAcknowledgmentView extends GetView<OrderAcknowledgmentController> {
  const OrderAcknowledgmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _buildAcknowledgmentCard(
              icon: Icons.local_laundry_service_outlined,
              title: 'Checked all pockets',
              subtitle:
                  'I confirm that all pockets have been checked and emptied of personal items.',
              value: controller.checkedPockets,
              onChanged: (val) => controller.togglePockets(val),
            ),
            SizedBox(height: 16.h),
            _buildAcknowledgmentCard(
              icon: Icons.inventory_2_outlined,
              title: 'Delicate items properly marked',
              subtitle:
                  'All delicate and fragile items have been identified and marked appropriately.',
              value: controller.delicateItemsMarked,
              onChanged: (val) => controller.toggleDelicate(val),
            ),
            SizedBox(height: 16.h),
            _buildAcknowledgmentCard(
              icon: Icons.warning_amber_rounded,
              title: 'Acknowledge wear and tear liability',
              subtitle:
                  'I understand and accept responsibility for normal wear and tear during the cleaning process.',
              value: controller.wearAndTearLiability,
              onChanged: (val) => controller.toggleLiability(val),
            ),
            const Spacer(),
            _buildProceedButton(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAcknowledgmentCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required RxBool value,
    required Function(bool?) onChanged,
  }) {
    return Container(
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
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xffF9F9F9),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22.sp, color: Colors.black),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A2530),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(
                    fontSize: 13.sp,
                    color: Colors.black45,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: value.value,
                onChanged: onChanged,
                activeColor: const Color(0xffB5DEEF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
                side: const BorderSide(color: Colors.black12, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProceedButton() {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: controller.isAllChecked
              ? const Color(0xffB5DEEF)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: controller.isAllChecked
              ? [
                  BoxShadow(
                    color: const Color(0xffB5DEEF).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: ElevatedButton(
          onPressed: controller.isAllChecked && !controller.isLoading.value
              ? () => controller.checkout()
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: controller.isLoading.value
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Proceed to Payment',
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.arrow_forward, size: 20.sp, color: Colors.white),
                  ],
                ),
        ),
      ),
    );
  }
}
