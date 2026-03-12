import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:laundry/modules/home/controllers/home_controller.dart';

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
  final BannerController _bannerController = Get.find<BannerController>();

  /// Banner map (easy to extend later)

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.put(BannerController());
    return Obx(() {
      if (bannerController.isLoading.value &&
          bannerController.banners.isEmpty) {
        return SizedBox(
          height: 180.h,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (bannerController.banners.isEmpty) {
        return SizedBox(height: 140.h);
      }

      return Column(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: _bannerController.banners.length,
            options: CarouselOptions(
              height: 140.h,
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
              // return _buildBannerItem(_bannerController.banners[index].image);
              return buildPromotionalBanner();
            },
          ),

          SizedBox(height: 12.h),

          _buildIndicators(),
        ],
      );
    });
  }

  /// Single banner item
  Widget _buildBannerItem(String imagePath) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 27, 26, 26), // white background
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (_, _, _) => const Icon(Icons.image_not_supported),
        ),
      ),
    );
  }

  /// Dot indicators
  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_bannerController.banners.length, (index) {
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
}

  Widget buildPromotionalBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dry Clean 30% OFF',
                  style: GoogleFonts.manrope(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'DEMO BANNER',
                  style: GoogleFonts.manrope(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color:  Colors.red,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Enjoy discounts on\nevery order',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: 100.w,
              height: 100.h,
              color: Colors.white.withOpacity(0.2),
              child: Icon(
                Icons.local_laundry_service,
                size: 50.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
