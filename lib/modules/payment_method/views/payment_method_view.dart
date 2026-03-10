import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/routes/app_pages.dart';
import '../controllers/payment_method_controller.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  const PaymentMethodView({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            _buildStepper(),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildPaymentCard(
                    id: 'card',
                    icon: Icons.credit_card,
                    title: 'Credit / Debit Card',
                    subtitle: 'Visa, Mastercard, Amex',
                    iconBgColor: const Color(0xffB5DEEF).withOpacity(0.6),
                  ),
                  SizedBox(height: 16.h),
                  _buildPaymentCard(
                    id: 'apple',
                    icon: Icons.apple,
                    title: 'Apple Pay',
                    subtitle: 'Fast & secure',
                    iconBgColor: Colors.black,
                    iconColor: Colors.white,
                  ),
                  SizedBox(height: 16.h),
                  _buildPaymentCard(
                    id: 'google',
                    icon: Icons.g_mobiledata_rounded,
                    title: 'Google Pay',
                    subtitle: 'Quick checkout',
                    iconBgColor: Colors.white,
                    border: Border.all(color: const Color(0xffF3F4F6)),
                  ),
                  SizedBox(height: 16.h),
                  _buildPaymentCard(
                    id: 'stripe',
                    icon: Icons.payments_outlined,
                    title: 'Stripe',
                    subtitle: 'Secure payment',
                    iconBgColor: const Color(0xff6366f1),
                    iconColor: Colors.white,
                  ),
                  SizedBox(height: 40.h),
                  _buildConfirmButton(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _stepItem(Icons.check, 'Service', true),
          _stepLine(true),
          _stepItem(Icons.check, 'Address', true),
          _stepLine(true),
          _stepItem(null, '3', false, label: 'Payment', isCurrent: true),
          _stepLine(false),
          _stepItem(null, '4', false, label: 'Confirm', isLast: true),
        ],
      ),
    );
  }

  Widget _stepItem(
    IconData? icon,
    String text,
    bool isCompleted, {
    String? label,
    bool isCurrent = false,
    bool isLast = false,
  }) {
    final themeColor = (isCompleted || isCurrent)
        ? const Color(0xffD3D3D3)
        : const Color(0xffE5E7EB);
    final iconColor = isCompleted ? Colors.white : Colors.grey.shade400;

    return Column(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: themeColor),
          child: Center(
            child: icon != null
                ? Icon(icon, size: 16.sp, color: iconColor)
                : Text(
                    text,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label ?? text,
          style: GoogleFonts.manrope(
            fontSize: 12.sp,
            fontWeight: isCompleted || isCurrent
                ? FontWeight.w500
                : FontWeight.w400,
            color: (isCompleted || isCurrent)
                ? Colors.grey.shade400
                : Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _stepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 1.5.h,
        margin: EdgeInsets.only(bottom: 25.h, left: 8.w, right: 8.w),
        color: const Color(0xffE5E7EB),
      ),
    );
  }

  Widget _buildPaymentCard({
    required String id,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconBgColor,
    Color iconColor = Colors.black,
    BoxBorder? border,
  }) {
    return Obx(() {
      final isSelected = controller.selectedMethod.value == id;
      return GestureDetector(
        onTap: () => controller.selectMethod(id),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? const Color(0xffB5DEEF) : Colors.transparent,
              width: 1.5.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: border,
                ),
                child: Icon(icon, color: iconColor, size: 28.sp),
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
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xffB5DEEF)
                        : Colors.grey.shade300,
                    width: isSelected ? 6.w : 1.5.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildConfirmButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xffB5DEEF),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffB5DEEF).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => Get.toNamed(AppRoutes.CARD_PAYMENT),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Confirm',
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
