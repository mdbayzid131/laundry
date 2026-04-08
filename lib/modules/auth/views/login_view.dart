import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/core/widgets/custom_elevated_button.dart';
import 'package:laundry/core/widgets/custom_text_field.dart';
import '../../../core/utils/validators.dart';
import '../controllers/login_controller.dart';
import '../../../config/themes/app_theme.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 80.h),

                // Lock Icon Placeholder
                Center(
                  child: Icon(
                    Icons.person_outline,
                    size: 60.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Login with your credentials to access your account and manage everything from one place.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    color: AppTheme.textLightColor,
                  ),
                ),
                SizedBox(height: 40.h),

                // Email Field
                SizedBox(height: 6.h),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'jhon@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  label: 'Email',
                ),
                SizedBox(height: 16.h),

                // Phone Field Placeholder (assuming controller has it, otherwise skip or add)
                SizedBox(height: 6.h),
                CustomTextField(
                  hintText: '015451246++',
                  keyboardType: TextInputType.phone,
                  label: 'Phone Number',
                  // We'll create a new controller variable or reuse if existing. For now, comment out controller or use a dummy
                  // controller: controller.phoneController,
                ),
                SizedBox(height: 16.h),

                // Password Field
                SizedBox(height: 6.h),
                Obx(
                  () => CustomTextField(
                    controller: controller.passwordController,
                    hintText: 'Enter your password',
                    obscureText: !controller.isPasswordVisible.value,
                    prefixIcon: const Icon(Icons.lock_outline, size: 20),
                    suffixIcon: GestureDetector(
                      onTap: controller.togglePasswordVisibility,
                      child: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                    ),
                    validator: Validators.password,
                    label: 'Password',
                  ),
                ),
                SizedBox(height: 12.h),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.goToForgotPassword,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot password?',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),

                // Login Button
                Obx(
                  () => CustomElevatedButton(
                    label: 'Sign In',
                    onPressed: controller.login,
                    isLoading: controller.isLoading.value,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.manrope(fontSize: 14.sp),
                    ),
                    TextButton(
                      onPressed: controller.goToRegister,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.manrope(
                          fontSize: 16.sp,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),

                // Social Login Section
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        'or continue with',
                        style: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Placeholder for Google Icon
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F3F3),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          ImagePaths.googleIcon,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    // Placeholder for Facebook Icon
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F3F3),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          ImagePaths.facebookIcon,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
