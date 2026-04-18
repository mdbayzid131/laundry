import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/themes/app_theme.dart';
import '../../../config/constants/image_paths.dart';
import '../../../config/routes/app_pages.dart';
import '../../../data/models/cart_model.dart';
import '../controllers/cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensuring ScreenUtil is initialized if not already (assuming it is in main)
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // light grey background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        title: Text(
          'Cart',
          style: GoogleFonts.manrope(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.cartData.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = controller.cartData.value?.items ?? [];

        if (items.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => controller.getCart(),
            color: AppTheme.primaryColor,
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80.sp,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Your cart is empty',
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.getCart(),
                color: AppTheme.primaryColor,
                backgroundColor: Colors.white,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _buildCartItem(item);
                  },
                ),
              ),
            ),
            _buildOrderSummary(),
          ],
        );
      }),
    );
  }

  Widget _buildCartItem(CartItemModel item) {
    String name = '';
    String image = '';
    String description = '';
    String price = item.price ?? '0.00';

    if (item.storeService != null) {
      name = item.storeService?.service?.name ?? 'Service';
      image = item.storeService?.service?.image ?? '';
      description = item.storeService?.service?.description ?? '';
    } else if (item.storeBundle != null) {
      name = item.storeBundle?.bundle?.name ?? 'Bundle';
      image = item.storeBundle?.bundle?.image ?? '';
      description = item.storeBundle?.bundle?.description ?? '';
    }

    return Container(
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          Container(
            width: 75.w,
            height: 75.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(12.r),
              image: image.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: image.isEmpty
                ? Icon(Icons.image_outlined, color: Colors.grey, size: 30.sp)
                : null,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: GoogleFonts.manrope(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff1A2530),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.deleteCartItem(item.id!),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          ImagePaths.deleteIcon,
                          width: 14.w,
                          height: 14.w,
                        ),
                      ),
                    ),
                  ],
                ),
                if (item.selectedAddons?.isNotEmpty ?? false) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Addons: ${item.selectedAddons!.map((e) => e.addon?.name).join(', ')}',
                    style: GoogleFonts.manrope(
                      fontSize: 11.sp,
                      color: const Color(0xff579796),
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$$price',
                      style: GoogleFonts.manrope(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        _buildQtyBtn(
                          icon: Icons.remove,
                          onTap: () => controller.updateQuantity(
                            item.id!,
                            (item.quantity ?? 0) - 1,
                          ),
                          isBlue: false,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          '${item.quantity ?? 0}',
                          style: GoogleFonts.manrope(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        _buildQtyBtn(
                          icon: Icons.add,
                          onTap: () => controller.updateQuantity(
                            item.id!,
                            (item.quantity ?? 0) + 1,
                          ),
                          isBlue: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn({
    required IconData icon,
    required VoidCallback onTap,
    required bool isBlue,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isBlue ? const Color(0xffB5DEEF) : Colors.grey.shade100,
          boxShadow: isBlue
              ? [
                  BoxShadow(
                    color: const Color(0xffB5DEEF).withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: isBlue ? Colors.white : Colors.black54,
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildSummaryRow(
              'Subtotal',
              '\$${controller.subTotal.toStringAsFixed(2)}',
              isBold: false,
            ),
            // SizedBox(height: 12.h),
            // _buildSummaryRow('Service Fee', '\$0.00', isBold: false),
            SizedBox(height: 12.h),
            _buildSummaryRow(
              'Pickup & Delivery fee',
              '${controller.cartData.value?.pickupAndDeliveryFee ?? 00}',
              isBold: false,
              isGreenText: true,
            ),
            SizedBox(height: 16.h),
            const Divider(color: Color(0xFFEEEEEE)),
            SizedBox(height: 16.h),
            _buildSummaryRow(
              'Total Amount',
              '\$${controller.totalAmount.toStringAsFixed(2)}',
              isBold: true,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.CHECKOUT,
                    arguments: {'cartData': controller.cartData.value},
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffB5DEEF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 4,
                  shadowColor: const Color(0xffB5DEEF).withOpacity(0.4),
                ),
                child: Text(
                  'Checkout',
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    String value, {
    bool isBold = false,
    bool isGreenText = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: isBold ? 16.sp : 14.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isBold ? Colors.black : Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: isBold ? 16.sp : 14.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: isGreenText
                ? const Color(0xFF2E7D32)
                : Colors.black, // Dark green for 'Free'
          ),
        ),
      ],
    );
  }
}
