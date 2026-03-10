import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/terms_conditions_controller.dart';

class TermsConditionsView extends GetView<TermsConditionsController> {
  const TermsConditionsView({super.key});

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
              SizedBox(height: 20.h),
              Icon(
                Icons.handshake_outlined,
                size: 80.sp,
                color: const Color(0xff1A2530),
              ),
              SizedBox(height: 24.h),
              Text(
                'Terms & Conditions',
                style: GoogleFonts.manrope(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xff1A2530),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Clear, simple, and fair terms for a better laundry experience.',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 32.h),

              // Highlights Section
              _buildHighlightsCard(),
              SizedBox(height: 24.h),

              // Service Usage Section
              _buildExpandableSection(
                Icons.local_laundry_service_outlined,
                'Service Usage',
                'We provide professional laundry services including washing, drying, and folding. Customers are responsible for checking pockets for valuables.',
                ['Pickup window: Monday - Sunday, 8 AM to 10 PM.'],
              ),
              SizedBox(height: 16.h),

              // Payments Section
              _buildInfoTile(
                Icons.payments_outlined,
                'Payments',
                'All payments are processed securely through our partners. Pricing is based on weight or item count as specified in our price list.',
              ),
              SizedBox(height: 16.h),

              // Refunds Section
              _buildInfoTile(
                Icons.history,
                'Refunds',
                'Cancellations made within 2 hours of the pickup window are subject to a small convenience fee. Refunds for unsatisfactory service are issued as app credit.',
              ),
              SizedBox(height: 16.h),

              // Liability Section
              _buildInfoTile(
                Icons.gavel_outlined,
                'Liability',
                'While we take the utmost care, we are not responsible for wear and tear, color bleeding, or shrinkage that occurs naturally during washing.',
              ),
              SizedBox(height: 40.h),

              // Actions
              _buildActionButtons(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xffB5DEEF).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                size: 20.sp,
                color: const Color(0xff1A2530),
              ),
              SizedBox(width: 8.w),
              Text(
                'MUST-KNOW HIGHLIGHTS',
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: const Color(0xff1A2530),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildHighlightItem(
            '24-Hour Turnaround: Standard service delivers within 24 hours.',
          ),
          SizedBox(height: 12.h),
          _buildHighlightItem(
            'Delicate Items: Must be specifically marked in the app before pickup.',
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, size: 16.sp, color: const Color(0xff1A2530)),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              color: const Color(0xff1A2530),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableSection(
    IconData icon,
    String title,
    String description,
    List<String> limits,
  ) {
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
      child: ExpansionTile(
        initiallyExpanded: true,
        shape: const Border(),
        tilePadding: EdgeInsets.all(16.w),
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xffF9F9F9),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          child: Icon(icon, color: const Color(0xff1A2530), size: 22.sp),
        ),
        title: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff1A2530),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: GoogleFonts.manrope(
                    fontSize: 13.sp,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'KEY LIMITATIONS',
                  style: GoogleFonts.manrope(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff1A2530),
                  ),
                ),
                SizedBox(height: 8.h),
                ...limits.map(
                  (limit) => Text(
                    '• $limit',
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xffF9F9F9),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.black.withOpacity(0.05)),
            ),
            child: Icon(icon, color: const Color(0xff1A2530), size: 22.sp),
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
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: GoogleFonts.manrope(
                    fontSize: 13.sp,
                    color: Colors.black54,
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

  Widget _buildActionButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: const Color(0xffB5DEEF),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffB5DEEF).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => controller.acceptTerms(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Accept Terms',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.arrow_forward, size: 20.sp, color: Colors.white),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: const Color(0xffF1F5F9),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextButton(
            onPressed: () => controller.downloadPDF(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.picture_as_pdf_outlined,
                  size: 20.sp,
                  color: const Color(0xff1A2530),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Download PDF',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A2530),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
