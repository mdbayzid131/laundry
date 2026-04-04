import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:laundry/modules/home/widget/promotion_banner.dart';
import 'package:laundry/modules/home/controllers/home_controller.dart';
import 'package:laundry/data/models/services_model.dart';

class LaundryHomeScreen extends StatefulWidget {
  const LaundryHomeScreen({super.key});

  @override
  State<LaundryHomeScreen> createState() => _LaundryHomeScreenState();
}

class _LaundryHomeScreenState extends State<LaundryHomeScreen> {
  final List<Map<String, String>> _pastOrders = [
    {
      'title': 'Wash & Fold',
      'image': ImagePaths.op4,
      'info': 'Available Today 9:30 AM',
      'rating': '4.8 (2k+) . 1.5 mi. 20 min',
    },
    {
      'title': 'Dry Cleaning',
      'image': ImagePaths.op5,
      'info': 'Pickup tomorrow 10:00 AM',
      'rating': '4.7 (1.2k+) . 3.0 mi. 45 min',
    },
    {
      'title': 'Premium Ironing',
      'image': ImagePaths.op6,
      'info': 'Available now',
      'rating': '4.9 (500+) . 0.8 mi. 15 min',
    },
  ];

  final List<Map<String, String>> _stealsAndDeals = [
    {
      'title': '30% Off Dry Clean',
      'image': ImagePaths.op4,
      'info': 'Limited Time Offer',
      'rating': '4.5 (800+) . 2.5 mi. 30 min',
    },
    {
      'title': 'Buy 1 Get 1 Wash',
      'image': ImagePaths.op5,
      'info': 'Weekly Special',
      'rating': '4.6 (1k+) . 1.2 mi. 25 min',
    },
    {
      'title': 'Free Pick-up',
      'image': ImagePaths.op6,
      'info': 'New Users Only',
      'rating': '4.8 (300+) . 4.0 mi. 50 min',
    },
  ];



  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            // Ongoing Order Banner
            _buildOngoingOrderStatusBanner(),

            // Top Address Bar
            _buildAddressBar(),

            // Search Bar
            _buildSearchBar(),

            // Scrollable Content
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.loadInitialData(showDialog: false),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Category Buttons
                      _buildCategoryButtons(),

                      // Promotional Banner
                      SizedBox(height: 16.h),
                      PromotionalBannerCarousel(),

                      // SizedBox(height: 24.h),

                      // // Long Cleaning Satisfied Section
                      // _buildLongCleaningSection(),
                      SizedBox(height: 24.h),

                      // Our Past Orders Section
                      _buildHorizontalListSection(
                        'Your Past Orders',
                        _pastOrders,
                      ),

                      SizedBox(height: 24.h),

                      // Steals & Deals Section
                      _buildHorizontalListSection(
                        'Steals & Deals',
                        _stealsAndDeals,
                        isLarge: true,
                      ),

                      SizedBox(height: 24.h),

                      // Dynamic Operator Services
                      Obx(() {
                        if (controller.isLoadingServices.value) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (controller.services.isEmpty) {
                          return const SizedBox();
                        }

                        // Group services by operator
                        final Map<String, List<ServiceData>> groupedServices = {};
                        for (var service in controller.services) {
                          final operatorName = service.operator?.storeName ?? 'Laundry Service';
                          if (!groupedServices.containsKey(operatorName)) {
                            groupedServices[operatorName] = [];
                          }
                          groupedServices[operatorName]!.add(service);
                        }

                        return Column(
                          children: groupedServices.entries.map((entry) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 24.h),
                              child: _buildDynamicServicesSection(
                                entry.key,
                                entry.value,
                              ),
                            );
                          }).toList(),
                        );
                      }),

                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOngoingOrderStatusBanner() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.ORDER_TRACKING);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20.w, 48.h, 20.w, 20.h),
        color: AppTheme.primaryColor,
        child: Row(
          children: [
            Icon(Icons.blur_on, color: Colors.white, size: 36.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7:20 - 7:30 PM estimated arrival',
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Your items are being cleaned',
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.black87, size: 24.sp),
          SizedBox(width: 8.w),
          Text(
            '11465 Woodside Avenue',
            style: GoogleFonts.manrope(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(Icons.keyboard_arrow_down, size: 24.sp, color: Colors.black87),
          const Spacer(),
          _buildIconButton(
            Icons.favorite,
            onTap: () => Get.toNamed(AppRoutes.FAVORITE),
          ),
          SizedBox(width: 12.w),
          _buildIconButton(
            Icons.notifications_none,
            onTap: () => Get.toNamed(AppRoutes.NOTIFICATIONS),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
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
        child: Icon(icon, size: 22.sp, color: Colors.black87),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // Light grey background
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: const Color(0xffB8B8B8), size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              'Search LaundryLink....',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                color: const Color(0xffB8B8B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButtons() {
    final HomeController controller = Get.find<HomeController>();
    return Obx(() {
      if (controller.isLoadingCategories.value) {
        return SizedBox(height: 65.h);
      }
      if (controller.categories.isEmpty) {
        return const SizedBox();
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: controller.categories
              .map((category) => _buildCategoryButton(category.name ?? ''))
              .toList(),
        ),
      );
    });
  }

  Widget _buildCategoryButton(String title) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to new page
      },
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.primaryColor),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalListSection(
    String title,
    List<Map<String, String>> dataList, {
    bool isLarge = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black87),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: isLarge ? 280.h : 230.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];
              return GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.PRODUCT_DETAILS), // TODO: pass actual routes?
                child: Container(
                  width: isLarge ? 300.w : 200.w,
                  margin: EdgeInsets.only(right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Container
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          height: isLarge ? 170.h : 140.h,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Image.asset(
                            // Using dummy images from constants
                            item['image'] ?? ImagePaths.product1,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.image_outlined,
                              size: 40.sp,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Availability & Favorite
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['info'] ?? '',
                            style: GoogleFonts.manrope(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          Icon(
                            Icons.favorite_border,
                            size: 18.sp,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),

                      // Title
                      Text(
                        item['title'] ?? '',
                        style: GoogleFonts.manrope(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),

                      // Rating & Distance/Time
                      Row(
                        children: [
                          Icon(Icons.star, size: 14.sp, color: Colors.black87),
                          SizedBox(width: 4.w),
                          Text(
                            item['rating'] ?? '',
                            style: GoogleFonts.manrope(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicServicesSection(
    String title,
    List<ServiceData> dataList, {
    bool isLarge = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black87),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: isLarge ? 280.h : 230.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];
              return GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.PRODUCT_DETAILS, arguments: {'serviceId': item.id}),
                child: Container(
                  width: isLarge ? 300.w : 200.w,
                  margin: EdgeInsets.only(right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Container
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          height: isLarge ? 170.h : 140.h,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: item.image != null
                              ? Image.network(
                                  item.image!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Icon(
                                    Icons.image_outlined,
                                    size: 40.sp,
                                    color: Colors.grey[400],
                                  ),
                                )
                              : Icon(
                                  Icons.image_outlined,
                                  size: 40.sp,
                                  color: Colors.grey[400],
                                ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Availability & Favorite
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.category?.name ?? 'Service',
                            style: GoogleFonts.manrope(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          Icon(
                            Icons.favorite_border,
                            size: 18.sp,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),

                      // Title
                      Text(
                        item.name ?? 'Service Name',
                        style: GoogleFonts.manrope(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),

                      // Rating & Distance/Time
                      Row(
                        children: [
                          Icon(Icons.star, size: 14.sp, color: Colors.black87),
                          SizedBox(width: 4.w),
                          Text(
                            '4.7 (1.2k+) . 3.0 mi. 45 min', // Static as requested
                            style: GoogleFonts.manrope(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  /// We removed _buildMobileCleanersSection as it was unused and replaced.
}
