import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/core/widgets/custom_back_button.dart';
import '../controllers/all_reviews_controller.dart';

class AllReviewsView extends GetView<AllReviewsController> {
  const AllReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  CustomBackButton(containerSize: 40.w, iconSize: 22.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'All Reviews',
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.reviews.isEmpty) {
                  return Center(
                    child: Text(
                      'No reviews available',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        color: Colors.black45,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  itemCount: controller.reviews.length,
                  separatorBuilder: (context, index) => SizedBox(height: 24.h),
                  itemBuilder: (context, index) {
                    final review = controller.reviews[index];
                    return _buildReviewItem(
                      review.user?.name ?? 'User',
                      review.comment ?? '',
                      review.user?.avatar ?? '',
                      review.rating ?? 5,
                      review.createdAt ?? '',
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(
    String name,
    String comment,
    String avatar,
    int rating,
    String date,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundImage: avatar.isNotEmpty
              ? NetworkImage(avatar)
              : AssetImage(ImagePaths.op6) as ImageProvider,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        size: 14.sp,
                        color: Colors.black,
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                comment,
                style: GoogleFonts.manrope(
                  fontSize: 13.sp,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                _formatDate(date),
                style: GoogleFonts.manrope(
                  fontSize: 11.sp,
                  color: const Color(0xff008080).withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(String isoDate) {
    if (isoDate.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(isoDate);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return 'Posted ${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return 'Posted ${difference.inHours} hours ago';
      } else {
        return 'Posted recently';
      }
    } catch (e) {
      return isoDate.substring(0, 10);
    }
  }
}
