import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/data/models/favorites_model.dart';
import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffF9F9F9),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Center(
            child: Container(
              height: 40.w,
              width: 40.w,
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
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18.sp,
                  color: Colors.black87,
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ),
        ),
        title: Text(
          'Favorites',
          style: GoogleFonts.manrope(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff1A2530),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.favoriteItems.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => controller.getFavorites(),
            child: ListView(
              children: [
                SizedBox(height: Get.height * 0.3),
                Center(
                  child: Text(
                    'No favorites found',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.getFavorites(),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            itemCount: controller.favoriteItems.length,
            itemBuilder: (context, index) {
              final FavoriteItem item = controller.favoriteItems[index];
              return _buildFavoriteCard(item);
            },
          ),
        );
      }),
    );
  }

  Widget _buildFavoriteCard(FavoriteItem favorite) {
    final service = favorite.storeService?.service;
    final store = favorite.storeService?.store;

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Item Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 100.w,
              height: 100.h,
              color: const Color(0xffF2F2F2),
              child: service?.image != null
                  ? Image.network(
                      service!.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
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
          SizedBox(width: 16.w),
          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        service?.name ?? 'Unknown Service',
                        style: GoogleFonts.manrope(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff1A2530),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.toggleFavorite(favorite),
                      child: Icon(
                        Icons.favorite,
                        size: 26.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  service?.description ?? 'Unknown Store',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${service?.basePrice ?? '0.00'}',
                      style: GoogleFonts.manrope(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff1A2530),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xffB5DEEF).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 18.sp,
                        color: const Color(0xff1A2530),
                      ),
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
}
