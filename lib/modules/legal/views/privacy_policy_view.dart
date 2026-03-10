import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80.h), // Space for back button
                _buildHeader(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      _buildExpandableSection(
                        icon: Icons.storage_outlined,
                        title: 'Data Collection',
                        subtitle: 'What information we gather',
                        content: Column(
                          children: [
                            _buildSubSection('Personal Information', [
                              'Name, email address, and phone number',
                              'Delivery addresses and location data',
                              'Payment information and transaction history',
                            ]),
                            SizedBox(height: 20.h),
                            _buildSubSection('Usage Information', [
                              'Order history and service preferences',
                              'Device information and IP address',
                              'App usage patterns and interactions',
                            ]),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      _buildExpandableSection(
                        icon: Icons.insights_outlined,
                        title: 'Data Usage',
                        subtitle: 'How we use your information',
                        isExpanded: true,
                        content: Column(
                          children: [
                            _buildInfoTile(
                              Icons.local_shipping_outlined,
                              'Service Delivery',
                              'Process orders, schedule pickups/deliveries, and manage your laundry service efficiently',
                            ),
                            _buildInfoTile(
                              Icons.notifications_none,
                              'Communication',
                              'Send order updates, promotional offers, and important service notifications.',
                            ),
                            _buildInfoTile(
                              Icons.help_outline,
                              'Personalization',
                              'Customize your experience with tailored recommendations and preferences.',
                            ),
                            _buildInfoTile(
                              Icons.security_outlined,
                              'Security & Fraud Prevention',
                              'Protect your account and prevent unauthorized access or fraudulent activities.',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 220.h), // Increased space for footer
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildFooter()),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(24.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xffB5DEEF),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffB5DEEF).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Shield Decoration
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.shield_outlined,
              size: 120.sp,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.shield_outlined,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Privacy Policy',
                style: GoogleFonts.manrope(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'We\'re committed to protecting your personal information. Learn how we collect, use, and safeguard your data.',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Last updated: February 14, 2025',
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget content,
    bool isExpanded = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        shape: const Border(),
        tilePadding: EdgeInsets.all(16.w),
        leading: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xffB5DEEF).withOpacity(0.4),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: const Color(0xff1A2530), size: 24.sp),
        ),
        title: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff1A2530),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.manrope(fontSize: 13.sp, color: Colors.black45),
        ),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildSubSection(String title, List<String> items) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xff1A2530),
            ),
          ),
          SizedBox(height: 16.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16.sp,
                    color: const Color(0xffB5DEEF),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.sp, color: const Color(0xff1A2530)),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A2530),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.black45,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Obx(
                () => Checkbox(
                  value: controller.isAgreed.value,
                  onChanged: (val) => controller.toggleAgreement(val),
                  activeColor: const Color(0xffB5DEEF),
                ),
              ),
              Expanded(
                child: Text(
                  'I have read and agree to the Privacy Policy and understand how my personal data will be collected, used, and protected.',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Obx(
            () => Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                color: controller.isAgreed.value
                    ? const Color(0xffB5DEEF)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ElevatedButton(
                onPressed: controller.isAgreed.value
                    ? () => controller.acceptPolicy()
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Accept Privacy Policy',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 50.h,
      left: 20.w,
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
    );
  }
}
