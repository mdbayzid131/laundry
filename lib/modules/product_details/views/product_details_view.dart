import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/widgets/custom_back_button.dart';
import 'package:laundry/data/models/storage_services_model.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xffB5DEEF)),
            );
          }

          if (controller.serviceDetails.value == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load service details'),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => controller.getServiceDetails(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: RefreshIndicator(
                  color: const Color(0xffB5DEEF),
                  onRefresh: () => controller.getServiceDetails(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProductImageCard(),
                        SizedBox(height: 20.h),
                        _buildTitleAndRating(),
                        SizedBox(height: 8.h),
                        _buildPriceHeader(),
                        SizedBox(height: 24.h),
                        _buildVendorSection(),
                        SizedBox(height: 24.h),
                        _buildServiceHeader('Service'),
                        _buildPrimaryServiceCard(),

                        // Add-on Services Section
                        if (controller
                                .serviceDetails
                                .value
                                ?.service
                                ?.serviceAddons
                                ?.isNotEmpty ??
                            false) ...[
                          SizedBox(height: 24.h),
                          _buildServiceHeader('Add-on Services'),
                          _buildAddonServicesList(),
                        ],

                        SizedBox(height: 24.h),
                        _buildSpecialInstructions(),
                        SizedBox(height: 32.h),
                        _buildQuantitySection(),
                        SizedBox(height: 24.h),
                        _buildPricingBreakdown(),
                        SizedBox(height: 32.h),
                        _buildRelatedServices(),

                        // Customer Reviews Section
                        SizedBox(height: 40.h),
                        _buildCustomerReviews(),

                        // SizedBox(height: 32.h),
                        // _buildConfirmButton(),
                        SizedBox(
                          height: 120.h,
                        ), // Extra space for sticky bottom
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      bottomSheet: _buildStickyCartBar(),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffB5DEEF).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffB5DEEF),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          'Confirm',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          CustomBackButton(containerSize: 40.w, iconSize: 22.sp),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildProductImageCard() {
    return Container(
      width: double.infinity,
      height: 300.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Obx(() {
            final image = controller.serviceDetails.value?.service?.image;
            if (image != null && image.isNotEmpty) {
              return Image.network(
                image,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    Image.asset(ImagePaths.shirtPhoto, fit: BoxFit.contain),
              );
            }
            return Image.asset(ImagePaths.shirtPhoto, fit: BoxFit.contain);
          }),
        ),
      ),
    );
  }

  Widget _buildTitleAndRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            controller.serviceDetails.value?.service?.name ?? 'Service Details',
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xff1A2530),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star_rounded,
                  color: index < 4
                      ? Colors.black
                      : Colors.black.withOpacity(0.3),
                  size: 18.sp,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Obx(
              () => Text(
                '4.8 (${controller.serviceDetails.value?.count?.reviews ?? 0} reviews)',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceHeader() {
    return Obx(
      () => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '\$${controller.basePrice.value.toStringAsFixed(2)}',
              style: GoogleFonts.manrope(
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xff1A2530),
              ),
            ),
            TextSpan(
              text: ' per piece',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorSection() {
    return Obx(() {
      final store = controller.serviceDetails.value?.store;
      return GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRoutes.LAUNDRY_DETAILS,
            arguments: {'storeId': store?.id, 'operatorId': store?.operatorId},
          );
        },
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.blue.shade50,
                backgroundImage: store?.logo != null
                    ? NetworkImage(store!.logo!)
                    : null,
                child: store?.logo == null
                    ? Text(store?.name?.substring(0, 1) ?? 'V')
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store?.name ?? 'Vendor',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xff1A2530),
                      ),
                    ),
                    Text(
                      store?.isActive == true ? 'Available' : 'Unavailable',
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        color: store?.isActive == true
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildServiceHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
          color: const Color(0xff1A2530),
        ),
      ),
    );
  }

  Widget _buildPrimaryServiceCard() {
    return Obx(() {
      final category = controller.serviceDetails.value?.service?.category;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xffB5DEEF).withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category?.name ?? 'Standard Service',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xff1A2530),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              category?.description ?? 'Premium quality cleaning',
              style: GoogleFonts.manrope(
                fontSize: 12.sp,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAddonServicesList() {
    return Obx(() {
      final addons = controller.serviceDetails.value?.service?.serviceAddons;
      if (addons == null || addons.isEmpty) {
        return const SizedBox();
      }
      return Column(
        children: addons.map((addonWrapper) {
          final addonItem = addonWrapper.addon;
          if (addonItem == null) return const SizedBox();
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildAddonItem(
              addonItem.name ?? 'Addon',
              addonItem.description ?? '',
              '+\$${addonItem.price ?? '0'}',
              controller.selectedAddons[addonItem.id] ?? false,
              () => controller.toggleAddon(addonItem.id!),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildAddonItem(
    String title,
    String subtitle,
    String price,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xffB5DEEF)
                : Colors.black.withOpacity(0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: isSelected ? const Color(0xffB5DEEF) : Colors.black12,
                  width: 2,
                ),
                color: isSelected
                    ? const Color(0xffB5DEEF)
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: GoogleFonts.manrope(
                        fontSize: 11.sp,
                        color: Colors.black38,
                      ),
                    ),
                ],
              ),
            ),
            Text(
              price,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xff1A2530),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildServiceHeader('Special Instructions (Optional)'),
        Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          child: TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  'e.g., Extra care for delicate fabric, specific stain location...',
              hintStyle: GoogleFonts.manrope(
                fontSize: 12.sp,
                color: Colors.black26,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Quantity',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: const Color(0xff1A2530),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: controller.decrementQuantity,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12),
                ),
                child: Icon(Icons.remove, size: 20.sp, color: Colors.black45),
              ),
            ),
            SizedBox(width: 20.w),
            Obx(
              () => Text(
                '${controller.quantity.value}',
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            GestureDetector(
              onTap: controller.incrementQuantity,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffB5DEEF),
                ),
                child: Icon(Icons.add, size: 20.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPricingBreakdown() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
      ),
      child: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Base price',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    color: Colors.black45,
                  ),
                ),
                Text(
                  '\$${controller.basePrice.value.toStringAsFixed(2)}',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xff1A2530),
                  ),
                ),
                Text(
                  '\$${controller.totalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xff1A2530),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedServices() {
    return Obx(() {
      if (controller.isLoadingRelatedServices.value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServiceHeader('Related Services'),
            const Center(child: CircularProgressIndicator()),
          ],
        );
      }

      if (controller.relatedServices.isEmpty) {
        return const SizedBox();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.link_rounded, size: 20.sp, color: Colors.black26),
              SizedBox(width: 8.w),
              _buildServiceHeader('Related Services'),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: controller.relatedServices.map((item) {
                return _buildRelatedCard(item);
              }).toList(),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildRelatedCard(StoreServiceData item) {
    final title = item.service?.name ?? 'Service';
    final image = item.service?.image ?? '';
    final price = item.service?.basePrice ?? '0';
    final rating = item.avgRating ?? 4.8;
    final reviews = item.totalReviews ?? 0;

    return GestureDetector(
      onTap: () {
        Get.offNamed(
          AppRoutes.PRODUCT_DETAILS,
          arguments: {
            'serviceId': item.id,
            'operatorId': item.service?.operatorId,
            'categoryId': item.service?.categoryId,
          },
          preventDuplicates: false,
        );
      },
      child: Container(
        width: 160.w,
        margin: EdgeInsets.only(right: 16.w),
        padding: EdgeInsets.all(12.w),
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: image.isNotEmpty
                      ? Image.network(
                          image,
                          height: 100.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset(
                            ImagePaths.op3,
                            height: 100.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          ImagePaths.op3,
                          height: 100.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.shopping_cart_outlined, size: 14.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(Icons.star, size: 10.sp, color: Colors.black),
                Text(
                  ' $rating ($reviews+)',
                  style: GoogleFonts.manrope(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              '\$$price/piece',
              style: GoogleFonts.manrope(
                fontSize: 10.sp,
                color: Colors.black45,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Customer Reviews',
              style: GoogleFonts.manrope(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xff1A2530),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.RATE_REVIEW,
                  arguments: {
                    'storeServiceId': controller.serviceDetails.value?.id,
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xffB5DEEF),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffB5DEEF).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_note_rounded,
                      size: 22.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Write a Review',
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Obx(() {
          final reviews = controller.serviceDetails.value?.reviews ?? [];
          if (reviews.isEmpty) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.black.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    size: 40.sp,
                    color: const Color(0xffB5DEEF),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'No reviews yet',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Be the first to share your experience with this service!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              ...reviews.take(2).map((review) {
                return _buildReviewItem(
                  review.user?.name ?? 'User',
                  review.comment ?? '',
                  'Posted ${review.createdAt?.substring(0, 10)}',
                  review.user?.avatar ?? '',
                  review.rating ?? 5,
                );
              }),
              if (reviews.length > 1) ...[
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.ALL_REVIEWS,
                      arguments: {
                        'storeServiceId': controller.serviceDetails.value?.id,
                      },
                    );
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'See all reviews',
                          style: GoogleFonts.manrope(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black45,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 20.sp,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ],
    );
  }

  Widget _buildReviewItem(
    String name,
    String comment,
    String time,
    String avatar,
    int rating,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
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
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star_rounded,
                          color: index < rating ? Colors.black : Colors.black12,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  comment,
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  time,
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: const Color(0xff579796),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyCartBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => RichText(
                text: TextSpan(
                  style: GoogleFonts.manrope(color: const Color(0xff1A2530)),
                  children: [
                    TextSpan(
                      text: 'Cart: ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '${controller.quantity.value} items • ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: '\$${controller.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isAddingToCart.value
                  ? null
                  : () => controller.addToCart(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffB5DEEF),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: controller.isAddingToCart.value
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Add to Cart',
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
