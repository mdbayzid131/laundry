import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:laundry/core/widgets/custom_back_button.dart';
import 'package:get/get.dart';
import 'package:laundry/modules/profile/controllers/phone_support_controller.dart';

class PhoneSupportScreen extends GetView<PhoneSupportController> {
  const PhoneSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CustomBackButton(),
        title: Text(
          'Phone Support',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final phoneSupport =
            controller.phoneSupportData.value?.data?.firstOrNull;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),

                // Phone Support Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Icon
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF81D4FA).withOpacity(0.3),
                              blurRadius: 15.r,
                              offset: Offset(0, 8.h),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.headset_mic_outlined,
                          size: 36.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Title
                      Text(
                        'Phone Support',
                        style: GoogleFonts.manrope(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Description
                      Text(
                        'Call us for immediate assistance. Our team is\nready to help you.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                if (phoneSupport?.number != null && phoneSupport!.number!.isNotEmpty) ...[
                  Text(
                    phoneSupport.number!,
                    style: GoogleFonts.manrope(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Call Now Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton.icon(
                    onPressed: controller.makePhoneCall,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48.h),
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    icon: Icon(Icons.phone, size: 22.sp, color: Colors.white),
                    label: Text(
                      'Call Now',
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Availability Info
                Text(
                  "Available ${phoneSupport?.availableTime ?? '9 AM - 9 PM EST'}",
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Average wait time: ${phoneSupport?.avgWaitTime ?? '<2 min'}',
                  style: GoogleFonts.manrope(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: 30.h),

                // Or reach us via
                Text(
                  'Or reach us via',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: 16.h),

                if (phoneSupport?.email != null && phoneSupport!.email!.isNotEmpty) ...[
                  Text(
                    phoneSupport.email!,
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Email Option
                GestureDetector(
                  onTap: controller.sendEmail,
                  child: Container(
                    width: 160.w,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10.r,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.email_outlined,
                            size: 24.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Email',
                          style: GoogleFonts.manrope(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                // Before You Call Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2196F3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.info_outline,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Before You Call',
                            style: GoogleFonts.manrope(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1976D2),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Tips
                      _buildTip(
                        'Have your order number ready for faster assistance',
                      ),
                      SizedBox(height: 12.h),
                      _buildTip('Check your account details before calling'),
                      SizedBox(height: 12.h),
                      _buildTip('Visit our FAQ section for quick answers'),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTip(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 4.h),
          width: 6.w,
          height: 6.w,
          decoration: const BoxDecoration(
            color: Color(0xFF2196F3),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1976D2),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
