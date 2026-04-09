import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:laundry/core/services/app_lock_service.dart';
import 'package:laundry/core/services/biometric_service.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  String biometricText = 'Biometric';

  @override
  void initState() {
    super.initState();
    _loadLabel();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _unlock();
    });
  }

  Future<void> _loadLabel() async {
    biometricText = await BiometricService.instance.biometricLabel();
    if (mounted) setState(() {});
  }

  Future<void> _unlock() async {
    final ok = await AppLockService.to.unlockWithBiometric();
    if (ok) {
      if (Get.previousRoute.isEmpty || Get.previousRoute == '/') {
        Get.offAllNamed(AppRoutes.SPLASH);
      } else {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.primaryColor.withOpacity(0.1), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Lock Icon
                Container(
                  padding: EdgeInsets.all(40.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.lock_person_rounded,
                    size: 80.sp,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(height: 48.h),
                Text(
                  'Welcome Back!',
                  style: GoogleFonts.manrope(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff1A2530),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Apps Locked for Security.\nPlease use $biometricText to continue.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const Spacer(),
                // Unlock Button
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: AppLockService.to.isAuthenticating.value
                          ? null
                          : _unlock,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: AppLockService.to.isAuthenticating.value
                          ? SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  biometricText.contains('Face')
                                      ? Icons.face
                                      : Icons.fingerprint,
                                  size: 24.sp,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  'Unlock with $biometricText',
                                  style: GoogleFonts.manrope(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
