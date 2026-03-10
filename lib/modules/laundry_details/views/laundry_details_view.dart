import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/widgets/custom_back_button.dart';
import '../controllers/laundry_details_controller.dart';

class LaundryDetailsView extends GetView<LaundryDetailsController> {
  const LaundryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 16.h),
            _buildServiceToggle(),
            SizedBox(height: 16.h),
            _buildLocationAndTime(),
            _buildSectionHeader('Deals & Benefits'),
            _buildPromotionCard(),
            SizedBox(height: 24.h),
            _buildCategoryFilters(),
            SizedBox(height: 24.h),
            _buildPromotedServices(),
            _buildTabBar(),
            _buildServiceGrid(),
            _buildBundlesSection(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 280.h,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xffE2E8F0),
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(32.r),
            //   bottomRight: Radius.circular(32.r),
            // ),
          ),
          child: Image.asset(
            ImagePaths.op1,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Container(
          height: 280.h,
          width: double.infinity,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(32.r),
            //   bottomRight: Radius.circular(32.r),
            // ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.6),
              ],
            ),
          ),
        ),
        Positioned(
          top: 50.h,
          left: 5.w,
          child: CustomBackButton(containerSize: 40.w, iconSize: 25.sp),
        ),
        Positioned(
          bottom: 20.h,
          left: 20.w,
          right: 20.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.dry_cleaning,
                  color: const Color(0xff1A2530),
                  size: 25.sp,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Laundry Express',
                style: GoogleFonts.manrope(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                '2.5 mi',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Pricing & Fees',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xffB5DEEF),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceToggle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 50.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: const Color(0xffF9F9F9),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Obx(
          () => Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.toggleService(true),
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.isDelivery.value
                          ? const Color(0xffB5DEEF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Delivery',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: controller.isDelivery.value
                            ? Colors.white
                            : Colors.black45,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.toggleService(false),
                  child: Container(
                    decoration: BoxDecoration(
                      color: !controller.isDelivery.value
                          ? const Color(0xffB5DEEF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Pickup',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: !controller.isDelivery.value
                            ? Colors.white
                            : Colors.black45,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationAndTime() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffF1F5F9)),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20.sp,
              color: const Color(0xff1A2530),
            ),
            SizedBox(width: 8.w),
            Text(
              '2.5 mi away',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 20.w),
            Icon(
              Icons.access_time,
              size: 20.sp,
              color: const Color(0xff1A2530),
            ),
            SizedBox(width: 8.w),
            Text(
              '30 min',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 18.sp,
          fontWeight: FontWeight.w800,
          color: const Color(0xff1A2530),
        ),
      ),
    );
  }

  Widget _buildPromotionCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xffF1F5FF),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: const BoxDecoration(
                color: Color(0xffB5DEEF),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.star, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LaundryLink Plus',
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Exclusive member benefits',
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: controller.categories
            .map(
              (cat) => GestureDetector(
                onTap: () => controller.selectCategory(cat),
                child: Container(
                  width: 110.w,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: controller.selectedCategory.value == cat
                          ? const Color(0xffB5DEEF)
                          : const Color(0xffF1F5F9),
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cat,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: controller.selectedCategory.value == cat
                          ? const Color(0xff1A2530)
                          : Colors.black38,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPromotedServices() {
    return Column(
      children: [
        _buildPromotedCard(
          'Dry Clean',
          ImagePaths.op2,
          '4.6 (5k+)',
          '2.2 mi, 30 min',
          '\$12.14/piece',
          'delivery fee on \$2.00',
        ),
        _buildPromotedCard(
          'Dry Clean',
          ImagePaths.op3,
          '4.6 (5k+)',
          '2.2 mi, 30 min',
          '\$12.14/piece',
          'delivery fee on \$2.00',
        ),
      ],
    );
  }

  Widget _buildPromotedCard(
    String title,
    String image,
    String rating,
    String info,
    String price,
    String delivery,
  ) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.PRODUCT_DETAILS),
      child: Container(
        margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xffF1F5F9)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: Image.asset(
                    image,
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, size: 20.sp, color: Colors.black),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.manrope(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14.sp, color: Colors.amber),
                      SizedBox(width: 4.w),
                      Text(
                        rating,
                        style: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '•',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        info,
                        style: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: price,
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(
                          text: ' • $delivery',
                          style: GoogleFonts.manrope(
                            fontSize: 12.sp,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: controller.tabs
              .map(
                (tab) => GestureDetector(
                  onTap: () => controller.selectTab(tab),
                  child: Column(
                    children: [
                      Text(
                        tab,
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: controller.activeTab.value == tab
                              ? FontWeight.w800
                              : FontWeight.w600,
                          color: controller.activeTab.value == tab
                              ? const Color(0xff1A2530)
                              : Colors.black38,
                        ),
                      ),
                      if (controller.activeTab.value == tab)
                        Container(
                          margin: EdgeInsets.only(top: 8.h),
                          height: 2.h,
                          width: 60.w,
                          color: const Color(0xff1A2530),
                        ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildServiceGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      children: [
        _buildGridItem('Wash', ImagePaths.op4),
        _buildGridItem('Wash', ImagePaths.op5),
        _buildGridItem('Wash', ImagePaths.op6),
        _buildGridItem('Wash', ImagePaths.op7),
      ],
    );
  }

  Widget _buildGridItem(String title, String image) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.PRODUCT_DETAILS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  image,
                  height: 140.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.shopping_cart_outlined, size: 16.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Icon(
                Icons.favorite_border,
                size: 18,
                color: Colors.black26,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.star, size: 12.sp, color: Colors.amber),
              Text(
                ' 4.6 (5k+)',
                style: GoogleFonts.manrope(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            '\$12.14/piece • \$2.00 fee',
            style: GoogleFonts.manrope(fontSize: 10.sp, color: Colors.black45),
          ),
        ],
      ),
    );
  }

  Widget _buildBundlesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Bundles'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Delivered right to my doorstep? Sign me up!',
            style: GoogleFonts.manrope(fontSize: 12.sp, color: Colors.black45),
          ),
        ),
        SizedBox(height: 20.h),
        _buildBundleItem(
          'The Signature',
          'Full garment care. Dry clean plus press. Premium standard.',
          ImagePaths.op8,
        ),
        _buildBundleItem(
          'The Executive',
          'Dress shirts, slacks, blazers. Ready for work without thinking about it.',
          ImagePaths.op9,
        ),
      ],
    );
  }

  Widget _buildBundleItem(String title, String subtitle, String image) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xffF1F5F9)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.black45,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              image,
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: const Color(0xffF9F9F9),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black.withOpacity(0.05)),
            ),
            child: Icon(Icons.add, size: 20.sp),
          ),
        ],
      ),
    );
  }
}
