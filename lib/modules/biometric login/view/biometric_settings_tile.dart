import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/core/services/app_lock_service.dart';
import 'package:laundry/core/services/biometric_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BiometricSettingsTile extends StatefulWidget {
  const BiometricSettingsTile({super.key});

  @override
  State<BiometricSettingsTile> createState() => _BiometricSettingsTileState();
}

class _BiometricSettingsTileState extends State<BiometricSettingsTile> {
  String _title = 'Biometric Login';
  String _subtitle = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadTitle();
  }

  Future<void> _loadTitle() async {
    final text = await BiometricService.instance.biometricLabel();
    if (mounted) {
      setState(() {
        _title = text;
        _subtitle = 'Use $text for quick access';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xffF9F9F9),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.black.withOpacity(0.05)),
              ),
              child: Icon(
                _title.contains('Face') ? Icons.face : Icons.fingerprint,
                size: 22.sp,
                color: const Color(0xff1A2530),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title,
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _subtitle,
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: AppLockService.to.biometricEnabled.value,
              onChanged: (value) async {
                await AppLockService.to.setBiometricEnabled(value);
              },
              activeColor: Colors.white,
              activeTrackColor: const Color(0xffB5DEEF),
            ),
          ],
        ),
      ),
    );
  }
}