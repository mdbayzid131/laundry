import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:laundry/modules/home/controllers/home_controller.dart';
import 'package:laundry/data/models/banner_model.dart';
import 'package:shimmer/shimmer.dart';

import 'package:laundry/core/utils/gradient_parser.dart';

class PromotionalBannerCarousel extends StatefulWidget {
  const PromotionalBannerCarousel({super.key});

  @override
  State<PromotionalBannerCarousel> createState() =>
      _PromotionalBannerCarouselState();
}

class _PromotionalBannerCarouselState extends State<PromotionalBannerCarousel> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_homeController.isLoadingBanners.value &&
          _homeController.banners.isEmpty) {
        return _buildShimmerLoading();
      }

      if (_homeController.banners.isEmpty) {
        return const SizedBox();
      }

      return Column(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: _homeController.banners.length,
            options: CarouselOptions(
              height: 180.h,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return buildPromotionalBanner(_homeController.banners[index]);
            },
          ),
          SizedBox(height: 12.h),
          _buildIndicators(),
        ],
      );
    });
  }

  Widget buildPromotionalBanner(BannerData banner) {
    // Helper to highlight percentages in green
    List<TextSpan> _buildTitleSpans(String title) {
      final spans = <TextSpan>[];
      final regex = RegExp(r'(\d+%)');
      final matches = regex.allMatches(title);
      int lastIndex = 0;

      for (final match in matches) {
        if (match.start > lastIndex) {
          spans.add(TextSpan(text: title.substring(lastIndex, match.start)));
        }
        spans.add(
          TextSpan(
            text: match.group(0),
            style: const TextStyle(color: Color(0xFF4ADE80)), // Bright green
          ),
        );
        lastIndex = match.end;
      }

      if (lastIndex < title.length) {
        spans.add(TextSpan(text: title.substring(lastIndex)));
      }
      return spans;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: GradientParser.parse(banner.backgroundColor),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.manrope(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                    children: _buildTitleSpans(banner.title ?? ''),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  banner.description ?? '',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (banner.bannerType == "MEMBERSHIP") {
                      Get.toNamed(AppRoutes.MEMBERSHIP);
                    } else {
                      
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      banner.buttonText ?? 'Schedule Now',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
                child: (banner.image != null && banner.image!.isNotEmpty)
                    ? Image.network(
                        banner.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.image,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      )
                    : Icon(
                        Icons.local_laundry_service,
                        size: 40.sp,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_homeController.banners.length, (index) {
        final isActive = _currentIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 22.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primaryColor : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(10.r),
          ),
        );
      }),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 180.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}
