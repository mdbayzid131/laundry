import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/widgets/custom_back_button.dart';
import 'package:laundry/core/widgets/custom_elevated_button.dart';
import 'package:pinput/pinput.dart';
import '../controllers/oto_controller.dart';
import '../../../config/themes/app_theme.dart';

class OtpVerifyScreen extends GetView<OtpController> {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: CustomBackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),

              // Icon Placeholder (Shield with Lock)
              Center(
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black87, width: 1.5),
                  ),
                  child: Icon(
                    Icons.shield_outlined,
                    size: 40.sp,
                    color: AppTheme.textColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              Text(
                'Verify OTP',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              SizedBox(height: 10.h),

              Text(
                "Enter the 6-digit code sent to your email\n${controller.email}",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: AppTheme.textLightColor,
                ),
              ),
              SizedBox(height: 40.h),

              // OTP Input Boxes (Placeholder using Row of Containers/TextFields)
              Pinput(
                controller: controller.otpController,
                length: 6,

                separatorBuilder: (index) => SizedBox(width: 20.w),
                defaultPinTheme: PinTheme(
                  width: 50.w,
                  height: 50.h,
                  textStyle: GoogleFonts.manrope(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff000000).withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Color(0xffFFFFFF), width: 1),
                  ),
                ),
              ),
              SizedBox(height: 40.h),

              // Verify Button
              Obx(
                () => CustomElevatedButton(
                  label: 'Verify',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.verifyOtp();
                  },
                ),
              ),
              SizedBox(height: 40.h),

              // Resend Code text
              Text(
                "Didn't receive the code?",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: AppTheme.textLightColor,
                ),
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.center, // full width prevent
                child: Obx(
                  () => TextButton(
                    onPressed: controller.isResendEnabled.value
                        ? () => controller.resendOtp()
                        : null,

                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                      // ✅ press color (only text area)
                      overlayColor: AppTheme.textColor.withOpacity(0.15),
                    ),

                    child: Text(
                      'Resend Code',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        color: controller.isResendEnabled.value
                            ? AppTheme.textColor
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Timer Badge
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.watch_later_outlined, color: Colors.white),
                      SizedBox(width: 5.w),
                      Text(
                        'Code expires in',
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Obx(() {
                        final minutes =
                            (controller.remainingSeconds.value ~/ 60)
                                .toString()
                                .padLeft(2, '0');
                        final seconds = (controller.remainingSeconds.value % 60)
                            .toString()
                            .padLeft(2, '0');
                        return Text(
                          '$minutes:$seconds',
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
