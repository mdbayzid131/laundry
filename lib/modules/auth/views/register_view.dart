import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/widgets/custom_back_button.dart';
import 'package:laundry/core/widgets/custom_elevated_button.dart';
import 'package:laundry/core/widgets/custom_text_field.dart';
import '../../../core/utils/validators.dart';
import '../controllers/register_controller.dart';
import '../../../config/themes/app_theme.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: CustomBackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10.h),

                SizedBox(height: 6.h),
                CustomTextField(
                  controller: controller.nameController,
                  hintText: 'Enter your name',
                  validator: (value) => Validators.name(value),
                  label: 'Name',
                ),
                SizedBox(height: 16.h),

                SizedBox(height: 6.h),
                CustomTextField(
                  controller: controller.phoneController,
                  hintText: 'Enter your number',
                  keyboardType: TextInputType.phone,
                  validator: (value) => Validators.phone(value),
                  label: 'Phone Number',
                ),
                SizedBox(height: 16.h),

                SizedBox(height: 6.h),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  label: 'Email',
                ),
                SizedBox(height: 16.h),

                Obx(
                  () => CustomTextField(
                    controller: controller.passwordController,
                    hintText: 'Enter your password',
                    obscureText: !controller.isPasswordVisible.value,
                    prefixIcon: const Icon(Icons.lock_outline, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: Validators.password,
                    label: 'Password',
                  ),
                ),
                SizedBox(height: 16.h),

                Obx(
                  () => CustomTextField(
                    controller: controller.confirmPasswordController,
                    hintText: 'Enter your confirm password',
                    obscureText: !controller.isPasswordVisible.value,
                    prefixIcon: const Icon(Icons.lock_outline, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: Validators.password,
                    label: 'Confirm Password',
                  ),
                ),
                SizedBox(height: 16.h),

                SizedBox(height: 6.h),
                CustomTextField(
                  controller: controller.addressController,
                  hintText: 'Enter your address',
                  label: 'Address',
                  validator: (value) => value == null || value.isEmpty ? 'Address is required' : null,
                ),
                SizedBox(height: 30.h),

                // Register Button
                Obx(
                  () => CustomElevatedButton(
                    label: 'Sign Up',
                    onPressed: controller.register,
                    isLoading: controller.isLoading.value,
                  ),
                ),
                SizedBox(height: 20.h),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        color: AppTheme.textLightColor,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.goToLogin,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
