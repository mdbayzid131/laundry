import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/widgets/custom_back_button.dart';
import 'package:laundry/core/widgets/custom_elevated_button.dart';
import 'package:laundry/core/widgets/custom_text_field.dart';
import 'package:laundry/modules/auth/controllers/oto_controller.dart';
import '../controllers/set_new_pass_controller.dart';
import '../../../config/themes/app_theme.dart';

class SetNewPasswordScreen extends GetView<SetNewPassController> {
  SetNewPasswordScreen({super.key});


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

              Text(
                'Create New Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              SizedBox(height: 10.h),

              Text(
                "Choose a strong password to\nsecure your account.",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: AppTheme.textLightColor,
                ),
              ),
              SizedBox(height: 40.h),

              CustomTextField(
                // controller: controller.newPasswordController,
                hintText: 'Enter your password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                label: 'New Password',
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                // controller: controller.confirmPasswordController,
                hintText: 'Enter your password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                label: 'Confirm Password',
              ),
              SizedBox(height: 30.h),

              // Password Requirements Area
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xffEFF6FF),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password must contain:',
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _buildRequirementRow(true, 'At least 8 characters'),
                    SizedBox(height: 6.h),
                    _buildRequirementRow(false, 'One uppercase letter'),
                    SizedBox(height: 6.h),
                    _buildRequirementRow(
                      false,
                      'One number or special character',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              // Verify Code (or Save Password) Button
              CustomElevatedButton(
                label: 'Verify Code', // Text from the design
                onPressed: controller.submitNewPassword,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementRow(bool isMet, String text) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isMet ? AppTheme.primaryColor : Colors.grey.shade400,
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: GoogleFonts.manrope(
            fontSize: 12.sp,
            color: isMet ? Colors.black87 : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
