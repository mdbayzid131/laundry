import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:laundry/data/models/steals_and_dals_model.dart';
import 'package:laundry/modules/home/widget/promotion_banner.dart';
import 'package:laundry/modules/home/controllers/home_controller.dart';
import 'package:laundry/data/models/storage_services_model.dart';
import 'package:laundry/data/models/category_model.dart';
import 'package:shimmer/shimmer.dart';

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
                onRefresh: () => controller.loadInitialData(),
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
                      Obx(() {
                        if (controller.isLoadingAds.value) {
                          return _buildServiceShimmer();
                        }
                        if (controller.ads.isEmpty) {
                          return const SizedBox();
                        }
                        return buildDynamicAdsSection(
                          'Steals & Deals',
                          controller.ads,
                          isLarge: true,
                        );
                      }),

                      SizedBox(height: 24.h),

                      // Dynamic Operator Services
                      Obx(() {
                        if (controller.isLoadingServices.value) {
                          return _buildServiceShimmer();
                        }
                        if (controller.services.isEmpty) {
                          return const SizedBox();
                        }

                        // Group services by operator
                        final Map<String, List<StoreServiceData>>
                        groupedServices = {};
                        for (var service in controller.services) {
                          final storeName =
                              service.store?.name ?? 'Nearest Store';
                          if (!groupedServices.containsKey(storeName)) {
                            groupedServices[storeName] = [];
                          }
                          groupedServices[storeName]!.add(service);
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
    final HomeController controller = Get.find<HomeController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.black87, size: 24.sp),
          SizedBox(width: 8.w),
          Obx(
            () => Expanded(
              child: GestureDetector(
                onTap: () => _showLocationSelectionBottomSheet(context),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.currentAddress.value,
                        style: GoogleFonts.manrope(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 24.sp,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
    final HomeController controller = Get.find<HomeController>();
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
            Expanded(
              child: TextField(
                onChanged: (value) => controller.onSearch(value),
                decoration: InputDecoration(
                  hintText: 'Search LaundryLink....',
                  hintStyle: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    color: const Color(0xffB8B8B8),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
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
        return _buildCategoryShimmer();
      }
      if (controller.categories.isEmpty) {
        return const SizedBox();
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: controller.categories
              .map((category) => _buildCategoryButton(category))
              .toList(),
        ),
      );
    });
  }

  Widget _buildCategoryShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: List.generate(
          5,
          (index) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              width: 100.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(width: 150.w, height: 24.h, color: Colors.white),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 230.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 200.w,
                  margin: EdgeInsets.only(right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 140.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: 100.w,
                        height: 12.h,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 150.w,
                        height: 16.h,
                        color: Colors.white,
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

  Widget _buildCategoryButton(CategoryData category) {
    final HomeController controller = Get.find<HomeController>();
    return Obx(() {
      final isSelected = controller.selectedCategoryId.value == category.id;
      return GestureDetector(
        onTap: () => controller.onCategorySelected(category.id ?? ''),
        child: Container(
          margin: EdgeInsets.only(right: 12.w),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : Colors.white,
            border: Border.all(
              color: isSelected ? Colors.transparent : AppTheme.primaryColor,
            ),
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
            category.name ?? '',
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      );
    });
  }

  void _showLocationSelectionBottomSheet(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Select Location',
              style: GoogleFonts.manrope(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h),

            // Current Location Option
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.my_location,
                    color: AppTheme.primaryColor,
                    size: 20.sp,
                  ),
                ),
                title: Text(
                  'Current Location',
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                subtitle: Text(
                  'Use GPS for accurate location',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () => controller.getCurrentLocation(),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.refresh,
                      color: AppTheme.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                ),
                onTap: () {
                  controller.getCurrentLocation();
                },
              ),
            ),

            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: EdgeInsets.all(16.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
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
                onTap: () => Get.toNamed(
                  AppRoutes.PRODUCT_DETAILS,
                ), // TODO: pass actual routes?
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
    List<StoreServiceData> dataList, {
    bool isLarge = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (dataList.isNotEmpty && dataList.first.storeId != null) {
              Get.toNamed(
                AppRoutes.LAUNDRY_DETAILS,
                arguments: {
                  'storeId': dataList.first.storeId,
                  'operatorId': dataList.first.service?.operatorId,
                },
              );
            }
            print(dataList.first.storeId);
          },
          child: Padding(
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
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: Colors.black87,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: isLarge ? 320.h : 280.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.PRODUCT_DETAILS,
                    arguments: {
                      'serviceId': item.id,
                      "operatorId": item.service?.operatorId,
                      "categoryId": item.service?.categoryId,
                    },
                  );
                  // ignore: avoid_print
                  print(
                    'serviceId: ${item.id}, operatorId: ${item.service?.operatorId}, categoryId: ${item.service?.categoryId}',
                  );
                },
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
                          child: item.service?.image != null
                              ? Image.network(
                                  item.service!.image!,
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.service?.name ?? 'Service Name',
                              style: GoogleFonts.manrope(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.favorite_border,
                            size: 24.sp,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),

                      // Rating, Distance, Time
                      Row(
                        children: [
                          Icon(Icons.star, size: 16.sp, color: Colors.black),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: Text(
                              "${item.avgRating ?? 4.6} (${item.totalReviews ?? 5}) . ${item.distanceMile?.toStringAsFixed(1) ?? '2.2'} mi. 30 min",
                              style: GoogleFonts.manrope(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Price & Delivery Fee
                      Row(
                        children: [
                          Text(
                            "\$${item.service?.basePrice?.toStringAsFixed(2) ?? '00.00'}",
                            style: GoogleFonts.manrope(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Flexible(
                          //   child: Text(
                          //     "delivery fee on .\$4.99",
                          //     style: GoogleFonts.manrope(
                          //       fontSize: 13.sp,
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.black,
                          //     ),
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
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

  Widget buildDynamicAdsSection(
    String title,
    List<AdData> dataList, {
    bool isLarge = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GestureDetector(
            //     onTap: () {
            //  Get.toNamed(
            //         AppRoutes.LAUNDRY_DETAILS,
            //         arguments: {
            //           'storeId': dataList.first.store?.id,
            //           'operatorId': dataList.first.operatorId,
            //         },
            //       );
            //     },
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
                // Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black87),
              ],
            ),
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
              final itemName = item.serviceName ?? item.bundleName ?? '';
              final itemImage = item.serviceImage ?? item.bundleImage ?? '';
              final rating = item.avgRating ?? 0.0;
              final reviews = item.totalReviewCount ?? 0;
              final distance = item.distanceMile != null
                  ? '${item.distanceMile!.toStringAsFixed(1)} mi'
                  : '';

              return GestureDetector(
                onTap: () {
                  if (item.id != null) {
                    print(item.id);
                    print(item.operatorId);
                    print(item.service?.categoryId);
                    Get.toNamed(
                      AppRoutes.PRODUCT_DETAILS,
                      arguments: {
                        'serviceId': item.storeServiceId,
                        'operatorId': item.operatorId,
                        'categoryId': item.service?.categoryId,
                      },
                    );
                  }
                },
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
                          child: itemImage.isNotEmpty
                              ? Image.network(
                                  itemImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => Icon(
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
                            item.status ?? 'Available',
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
                        itemName,
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
                            '$rating ($reviews+) . $distance',
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
}
