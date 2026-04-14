import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/issue_details_controller.dart';
import 'package:laundry/config/themes/app_theme.dart';

class IssueDetailsView extends GetView<IssueDetailsController> {
  const IssueDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Issue Details',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff1A2530),
          ),
        ),
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final issue = controller.issue.value;
        if (issue == null) {
          return const Center(child: Text('No details found'));
        }

        String dateFormatted = '';
        if (issue.createdAt != null) {
          try {
            final date = DateTime.parse(issue.createdAt!);
            dateFormatted = DateFormat('MMM dd, yyyy HH:mm').format(date);
          } catch (e) {
            dateFormatted = issue.createdAt!;
          }
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order #${issue.order?.orderNumber ?? 'N/A'}',
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff1A2530),
                          ),
                        ),
                        _buildStatusBadge(issue.status ?? 'PENDING'),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Issue Title',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      issue.issueTitle ?? 'N/A',
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff1A2530),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Description',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      issue.description ?? 'No description provided',
                      style: GoogleFonts.manrope(
                        fontSize: 15.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    if (issue.images != null && issue.images!.isNotEmpty) ...[
                      SizedBox(height: 20.h),
                      Text(
                        'Attachments',
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        height: 100.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: issue.images!.length,
                          separatorBuilder: (context, index) => SizedBox(width: 12.w),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                issue.images![index],
                                width: 100.w,
                                height: 100.h,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: 20.h),
                    Divider(color: Colors.grey[100]),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Submitted on',
                          style: GoogleFonts.manrope(
                            fontSize: 13.sp,
                            color: Colors.black45,
                          ),
                        ),
                        Text(
                          dateFormatted,
                          style: GoogleFonts.manrope(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              if (issue.operatorNote != null || issue.adminNote != null) ...[
                SizedBox(height: 20.h),
                Text(
                  'Support Response',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A2530),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (issue.operatorNote != null) ...[
                        Text(
                          'Operator Note',
                          style: GoogleFonts.manrope(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          issue.operatorNote!,
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        if (issue.adminNote != null) SizedBox(height: 16.h),
                      ],
                      if (issue.adminNote != null) ...[
                        Text(
                          'Admin Note',
                          style: GoogleFonts.manrope(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          issue.adminNote!,
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status.toUpperCase()) {
      case 'PENDING':
        color = Colors.orange;
        break;
      case 'RESOLVED':
        color = Colors.green;
        break;
      case 'REFUNDED':
        color = Colors.blue;
        break;
      default:
        color = AppTheme.primaryColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: GoogleFonts.manrope(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
