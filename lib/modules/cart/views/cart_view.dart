import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/routes/app_pages.dart';
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
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              itemCount: 3,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final items = [
                  {
                    'name': 'Premium Dress Shirt',
                    'type': 'Dry Clean',
                    'price': '\$18.00',
                  },
                  {
                    'name': 'Queen Bedsheet Set',
                    'type': 'Dry Clean',
                    'price': '\$18.00',
                  },
                  {
                    'name': 'Denim Jeans',
                    'type': 'Wash & Fold',
                    'price': '\$18.00',
                  },
                ];

                return _buildCartItem(
                  items[index]['name']!,
                  items[index]['type']!,
                  items[index]['price']!,
                );
              },
            ),
          ),
          _buildOrderSummary(),
        ],
      ),
    );
  }

  Widget _buildCartItem(String name, String type, String price) {
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
        children: [
          // Image Placeholder
          Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.image_outlined, color: Colors.grey, size: 30.sp),
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
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red.shade400,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  type,
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade100,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: 16.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          '2',
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFADD8E6), // Light blue
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                          ),
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
            _buildSummaryRow('Subtotal', '\$38.50', isBold: false),
            SizedBox(height: 12.h),
            _buildSummaryRow('Service Fee', '\$2.50', isBold: false),
            SizedBox(height: 12.h),
            _buildSummaryRow(
              'Delivery',
              'Free',
              isBold: false,
              isGreenText: true,
            ),
            SizedBox(height: 16.h),
            const Divider(color: Color(0xFFEEEEEE)),
            SizedBox(height: 16.h),
            _buildSummaryRow('Total Amount', '\$41.00', isBold: true),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.CHECKOUT);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFFADD8E6,
                  ), // Light blue checkout button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Checkout',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
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
