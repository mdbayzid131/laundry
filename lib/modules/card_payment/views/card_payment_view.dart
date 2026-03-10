import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/card_payment_controller.dart';

class CardPaymentView extends GetView<CardPaymentController> {
  const CardPaymentView({super.key});

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
          children: [
            SizedBox(height: 10.h),
            _buildStepper(),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCreditCardPreview(),
                  SizedBox(height: 32.h),
                  _buildLabel('Card Number'),
                  SizedBox(height: 12.h),
                  _buildTextField(
                    controller: controller.cardNumberController,
                    hintText: '1234 5678 9012 3456',
                    suffixIcon: Icons.credit_card,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Expiry Date'),
                            SizedBox(height: 12.h),
                            _buildTextField(
                              controller: controller.expiryController,
                              hintText: 'MM/YY',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('CVV'),
                            SizedBox(height: 12.h),
                            _buildTextField(
                              controller: controller.cvvController,
                              hintText: '123',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  _buildLabel('Cardholder Name'),
                  SizedBox(height: 12.h),
                  _buildTextField(
                    controller: controller.nameController,
                    hintText: 'John Doe',
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Save card for future payments',
                        style: GoogleFonts.manrope(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff1A2530),
                        ),
                      ),
                      Obx(
                        () => Switch(
                          value: controller.saveCard.value,
                          onChanged: (val) => controller.saveCard.value = val,
                          activeColor: Colors.white,
                          activeTrackColor: const Color(0xffB5DEEF),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  _buildSecurePaymentNotice(),
                  SizedBox(height: 40.h),
                  _buildConfirmButton(),
                  SizedBox(height: 24.h),
                  _buildTotalPriceSection(),
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
          _stepItem(Icons.check, 'Payment', true),
          _stepLine(false),
          _stepItem(
            null,
            '4',
            false,
            label: 'Confirm',
            isCurrent: true,
            isLast: true,
          ),
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
    final iconColor = isCompleted ? Colors.white : Colors.grey.shade300;

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

  Widget _buildCreditCardPreview() {
    return Container(
      height: 200.h,
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xff1A2530),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: const Color(0xffD4AF37),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              Text(
                'VISA',
                style: GoogleFonts.manrope(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '••••  ••••  ••••  ••••',
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card Holder',
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Your Name',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expires',
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'MM/YY',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.manrope(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xff1A2530),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.manrope(
        fontSize: 16.sp,
        color: const Color(0xff1A2530),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.manrope(fontSize: 16.sp, color: Colors.black26),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: const Color(0xffB5DEEF))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSecurePaymentNotice() {
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
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xffE2F5ED),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_outline,
              size: 24.sp,
              color: const Color(0xff22C55E),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your payment is encrypted and secure',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A2530),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Protected by 256-bit SSL encryption',
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
    );
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
        onPressed: () {},
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

  Widget _buildTotalPriceSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.manrope(fontSize: 14.sp, color: Colors.black45),
          children: [
            const TextSpan(text: 'Total:  '),
            TextSpan(
              text: '2 items • \$17.98',
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w800,
                color: const Color(0xff1A2530),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
