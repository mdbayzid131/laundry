import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/themes/app_theme.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int? expandedIndex;

  final List<FAQItem> faqs = [
    FAQItem(
      question: 'How do I track my order?',
      answer:
          'You can track your order in real-time through the app. Go to "My Orders" and tap on your active order to see pickup and delivery status.',
    ),
    FAQItem(
      question: 'What if my clothes are damaged?',
      answer:
          'Yes! You can reschedule up to 2 hours before your pickup time. Just go to your order and tap "Reschedule."',
    ),
    FAQItem(
      question: 'How do refunds work?',
      answer:
          'Refunds are processed back to your original payment method within 3-5 business days after approval.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),

                // Icon and Title
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 68.w,
                        height: 68.w,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            ImagePaths.shirtIcon,
                            height: 24.h,
                            width: 30.w,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'How can we help you today?',
                        style: GoogleFonts.manrope(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                // Get in Touch Section
                Text(
                  'Get in Touch',
                  style: GoogleFonts.manrope(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 16.h),

                // Support Options
                _buildSupportCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'Live Chat',
                  subtitle: 'Chat with our support team',
                  hasIndicator: true,
                ),

                SizedBox(height: 12.h),

                _buildSupportCard(
                  icon: Icons.email_outlined,
                  title: 'Email Support',
                  subtitle: 'We\'ll respond within 24 hours',
                ),

                SizedBox(height: 12.h),

                _buildSupportCard(
                  icon: Icons.phone_outlined,
                  title: 'Phone Support',
                  subtitle: 'Mon-Fri, 8AM-8PM EST',
                ),

                SizedBox(height: 12.h),

                _buildSupportCard(
                  icon: Icons.report_problem_outlined,
                  title: 'Order Issue',
                  subtitle: '',
                  showSubtitle: false,
                ),

                SizedBox(height: 40.h),

                // FAQ Section
                Text(
                  'Frequently Asked Questions',
                  style: GoogleFonts.manrope(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 16.h),

                // FAQ Items
                ...List.generate(
                  faqs.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: _buildFAQItem(index),
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupportCard({
    required IconData icon,
    required String title,
    required String subtitle,
    bool hasIndicator = false,
    bool showSubtitle = true,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20.r,
            offset: Offset(0, 4.h),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 3.r,
            offset: Offset(0, 1.h),
          ),
        ],
        border: Border.all(color: Color(0xffE5E7EB)),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 24.sp, color: Colors.black87),
          ),

          SizedBox(width: 16.w),

          // Title and Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (showSubtitle) ...[
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Indicator or Arrow
          if (hasIndicator)
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            )
          else
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black38),
        ],
      ),
    );
  }

  Widget _buildFAQItem(int index) {
    final faq = faqs[index];
    final isExpanded = expandedIndex == index;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                expandedIndex = isExpanded ? null : index;
              });
            },
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      faq.question,
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 24.sp,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Divider(height: 1.h, color: Colors.grey[200]),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
              child: Text(
                faq.answer,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
