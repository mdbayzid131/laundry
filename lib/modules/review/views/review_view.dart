import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/widgets/custom_back_button.dart';
import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  CustomBackButton(containerSize: 40.w, iconSize: 22.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Rate & Review',
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Text(
                'Rate this product',
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
              SizedBox(height: 16.h),
              _buildStarRating(),
              SizedBox(height: 32.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xffF8FAFC),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Write your review',
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff1A2530),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.black.withOpacity(0.05)),
                      ),
                      child: TextField(
                        controller: controller.commentController,
                        maxLines: 5,
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          color: const Color(0xff1A2530),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Excellent Service...................',
                          hintStyle: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            color: Colors.black26,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Obx(() => _buildSubmitButton()),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Obx(() => Row(
          children: List.generate(5, (index) {
            final isFull = index < controller.rating.value;
            return GestureDetector(
              onTap: () => controller.setRating(index + 1),
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Icon(
                  isFull ? Icons.star_rounded : Icons.star_outline_rounded,
                  size: 32.sp,
                  color: Colors.black,
                ),
              ),
            );
          }),
        ));
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: controller.isLoading.value ? null : controller.submitReview,
      child: Container(
        width: double.infinity,
        height: 56.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffB5DEEF),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: controller.isLoading.value
            ? SizedBox(
                height: 24.h,
                width: 24.h,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Submit',
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
