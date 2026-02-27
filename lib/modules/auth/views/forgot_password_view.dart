import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/widgets/custom_back_button.dart';
import 'package:laundry/core/widgets/custom_elevated_button.dart';
import 'package:laundry/core/widgets/custom_text_field.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/forgot_password_controller.dart';
import '../../../config/themes/app_theme.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CustomBackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.h),

                // Icon Placeholder
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.textColor, width: 1.5),
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: 40.sp,
                      color: AppTheme.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                Text(
                  'Forgot Password',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                SizedBox(height: 10.h),

                Text(
                  "Enter the email or phone your account and we'll \nsend a code to reset your password.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    color: AppTheme.textLightColor,
                  ),
                ),
                SizedBox(height: 40.h),

                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'jhon@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  label: 'Email',
                ),
                SizedBox(height: 30.h),

                // Send Button
                Obx(
                  () => CustomElevatedButton(
                    label: 'Send',
                    onPressed: () {
                      Get.toNamed(AppRoutes.OTP);
                    },
                    // onPressed: controller.sendResetLink,
                    isLoading: controller.isLoading.value,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
