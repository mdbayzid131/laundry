import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/modules/privacy_security/widgets/biometric_settings_tile.dart';
import '../controllers/privacy_security_controller.dart';

class PrivacySecurityView extends GetView<PrivacySecurityController> {
  const PrivacySecurityView({super.key});

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Privacy & Security',
                style: GoogleFonts.manrope(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xff1A2530),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Manage your data and keep your account secure',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 40.h),

              // Security Settings Section
              _buildSectionHeader(
                Icons.shield_outlined,
                'Security Settings',
                trailing: Icons.lock_outline,
              ),
              SizedBox(height: 16.h),
              _buildSettingsCard([
                _buildListTile(
                  Icons.lock_outline,
                  'Change Password',
                  'Update your account password',
                  hasNext: true,
                  onTap: () => Get.toNamed(AppRoutes.CHANGE_PASSWORD),
                ),
                _buildDivider(),
                const BiometricSettingsTile(),
              ]),
              SizedBox(height: 24.h),

              // Privacy Controls Section
              _buildSectionHeader(
                Icons.info_outline,
                'Privacy Controls',
              ), // Using info icon as proxy for ডিজাইন
              SizedBox(height: 16.h),
              _buildSettingsCard([
                _buildListTile(
                  Icons.notifications_none,
                  'Push Notifications',
                  'Order updates & promotions',
                ),
                _buildDivider(),
                _buildListTile(
                  Icons.location_on_outlined,
                  'Location Services',
                  'For pickup & delivery tracking',
                ),
              ]),
              SizedBox(height: 24.h),

              // Saved Payment Methods Section
              _buildSectionHeader(Icons.credit_card, 'Saved Payment Methods'),
              SizedBox(height: 16.h),
              Obx(
                () => _buildSettingsCard(
                  controller.savedPayments.asMap().entries.map((entry) {
                    final index = entry.key;
                    final payment = entry.value;
                    return Column(
                      children: [
                        _buildPaymentTile(
                          payment,
                          () => controller.removePayment(index),
                        ),
                        if (index < controller.savedPayments.length - 1)
                          _buildDivider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 24.h),

              // Legal Information Section
              _buildSectionHeader(
                Icons.description_outlined,
                'Legal Information',
              ),
              SizedBox(height: 16.h),
              _buildSettingsCard([
                _buildListTile(
                  Icons.verified_user_outlined,
                  'Privacy Policy',
                  '',
                  hasNext: true,
                  titleOnly: true,
                  onTap: () => Get.toNamed(AppRoutes.PRIVACY_POLICY),
                ),
                _buildDivider(),
                _buildListTile(
                  Icons.assignment_outlined,
                  'Terms & Conditions',
                  '',
                  hasNext: true,
                  titleOnly: true,
                  onTap: () => Get.toNamed(AppRoutes.TERMS_CONDITIONS),
                ),
              ]),
              SizedBox(height: 32.h),

              // Security Notice Card
              _buildSecurityNotice(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    IconData icon,
    String title, {
    IconData? trailing,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xffB5DEEF).withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20.sp, color: const Color(0xff1A2530)),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xff1A2530),
            ),
          ),
        ),
        if (trailing != null)
          Icon(trailing, size: 20.sp, color: const Color(0xff1A2530)),
      ],
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title,
    String subtitle, {
    bool hasNext = false,
    bool titleOnly = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
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
              child: Icon(icon, size: 22.sp, color: const Color(0xff1A2530)),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                  if (!titleOnly) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (hasNext)
              Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTile(PaymentMethodModel payment, VoidCallback onRemove) {
    return Padding(
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
              Icons.credit_card,
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
                  '${payment.brand} •••• ${payment.last4}',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A2530),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Expires ${payment.expiry}',
                  style: GoogleFonts.manrope(
                    fontSize: 13.sp,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onRemove,
            child: Text(
              'Remove',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: const Color(0xffF1F5F9), indent: 70.w);
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xffF9F9F9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline,
              size: 24.sp,
              color: const Color(0xff1A2530),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your data is safe with us',
                  style: GoogleFonts.manrope(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A2530),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'We use industry-standard encryption and never share your personal information with third parties without your consent.',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.black38,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
