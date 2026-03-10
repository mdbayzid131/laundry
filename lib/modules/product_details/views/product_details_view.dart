import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/core/widgets/custom_back_button.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                    SizedBox(height: 24.h),
                    _buildServiceHeader('Add-on Services'),
                    _buildAddonServicesList(),
                    SizedBox(height: 24.h),
                    _buildSpecialInstructions(),
                    SizedBox(height: 32.h),
                    _buildQuantitySection(),
                    SizedBox(height: 24.h),
                    _buildPricingBreakdown(),
                    SizedBox(height: 32.h),
                    _buildRelatedServices(),
                    SizedBox(height: 32.h),
                    _buildCustomerReviews(),
                    SizedBox(height: 100.h), // Bottom padding for sticky bar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _buildStickyBottomBar(),
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
          child: Image.asset(ImagePaths.shirtPhoto, fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget _buildTitleAndRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dry Clean - Blazer',
          style: GoogleFonts.manrope(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: const Color(0xff1A2530),
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
                      ? Colors.amber
                      : Colors.amber.withOpacity(0.3),
                  size: 18.sp,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '4.8 (127 reviews)',
              style: GoogleFonts.manrope(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black45,
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
    return Container(
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
            backgroundImage: AssetImage(ImagePaths.op2),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vendor',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff1A2530),
                  ),
                ),
                Text(
                  'Available',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.green,
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
    );
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
            'Standard Dry Clean',
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xff1A2530),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Order Ready within 24 hours',
            style: GoogleFonts.manrope(fontSize: 12.sp, color: Colors.black38),
          ),
        ],
      ),
    );
  }

  Widget _buildAddonServicesList() {
    return Column(
      children: [
        _buildAddonItem(
          'Express Service',
          'Order Ready within 24 hours',
          '+\$2.00',
          controller.expressService,
          controller.toggleExpressService,
        ),
        SizedBox(height: 12.h),
        _buildAddonItem(
          'Stain Removal',
          'Professional stain treatment',
          '+\$1.50',
          controller.stainRemoval,
          controller.toggleStainRemoval,
        ),
      ],
    );
  }

  Widget _buildAddonItem(
    String title,
    String subtitle,
    String price,
    RxBool value,
    VoidCallback onTap,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: value.value
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
                    color: value.value
                        ? const Color(0xffB5DEEF)
                        : Colors.black12,
                    width: 2,
                  ),
                  color: value.value
                      ? const Color(0xffB5DEEF)
                      : Colors.transparent,
                ),
                child: value.value
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
            children: [
              _buildRelatedCard('Wash', ImagePaths.op3),
              _buildRelatedCard('Wash', ImagePaths.op4),
              _buildRelatedCard('Wash', ImagePaths.op5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedCard(String title, String image) {
    return Container(
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
                child: Image.asset(
                  image,
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
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.star, size: 10.sp, color: Colors.amber),
              Text(
                ' 4.6 (5k+)',
                style: GoogleFonts.manrope(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            '\$12.14/piece',
            style: GoogleFonts.manrope(
              fontSize: 10.sp,
              color: Colors.black45,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
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
            _buildServiceHeader('Customer Reviews'),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xffB5DEEF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_note,
                      size: 18.sp,
                      color: const Color(0xffB5DEEF),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Write a Review',
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xffB5DEEF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        _buildReviewItem(
          'Rahim',
          'Excellent laundry service - fresh, clean, and perfectly folded.',
          'Posted 2 days ago',
          ImagePaths.op6,
        ),
        _buildReviewItem(
          'Sadia',
          'Excellent laundry service - fresh, clean, and perfectly folded.',
          'Posted 5 days ago',
          ImagePaths.op7,
        ),
        SizedBox(height: 16.h),
        Center(
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
      ],
    );
  }

  Widget _buildReviewItem(
    String name,
    String comment,
    String time,
    String avatar,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20.r, backgroundImage: AssetImage(avatar)),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 14.sp,
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
                    fontSize: 11.sp,
                    color: const Color(0xffB5DEEF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cart: 2 items • \$17.98',
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffB5DEEF),
              minimumSize: Size(150.w, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Add to Cart',
              style: GoogleFonts.manrope(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
