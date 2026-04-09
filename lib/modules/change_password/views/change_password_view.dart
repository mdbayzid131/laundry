import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/themes/app_theme.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Change Password',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create New Password',
                style: GoogleFonts.manrope(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xff1A2530),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your new password must be different from previous passwords.',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 32.h),

              _buildPasswordField(
                label: 'Current Password',
                hint: 'Enter current password',
                textController: controller.oldPasswordController,
                obscureText: controller.obscureOldPassword,
              ),
              SizedBox(height: 20.h),

              _buildPasswordField(
                label: 'New Password',
                hint: 'Enter new password',
                textController: controller.newPasswordController,
                obscureText: controller.obscureNewPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              _buildPasswordField(
                label: 'Confirm New Password',
                hint: 'Confirm new password',
                textController: controller.confirmPasswordController,
                obscureText: controller.obscureConfirmPassword,
                validator: (value) {
                  if (value != controller.newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              SizedBox(height: 48.h),

              Obx(() => SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value 
                    ? null 
                    : () => controller.changePassword(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Reset Password',
                        style: GoogleFonts.manrope(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController textController,
    required RxBool obscureText,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff1A2530),
          ),
        ),
        SizedBox(height: 8.h),
        Obx(() => TextFormField(
          controller: textController,
          obscureText: obscureText.value,
          style: GoogleFonts.manrope(fontSize: 15.sp),
          validator: validator ?? (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: Colors.black26,
            ),
            filled: true,
            fillColor: const Color(0xffF9F9F9),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w, 
              vertical: 18.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText.value 
                  ? Icons.visibility_off_outlined 
                  : Icons.visibility_outlined,
                color: Colors.black45,
                size: 20.sp,
              ),
              onPressed: () => obscureText.toggle(),
            ),
          ),
        )),
      ],
    );
  }
}
