import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/themes/app_theme.dart';
import 'package:laundry/modules/cart/views/cart_view.dart';
import 'package:laundry/modules/map/views/map_screen.dart';
import '../controllers/bottom_nab_bar.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [
             LaundryHomeScreen(),
            const MapScreen(),
            const CartScreen(),
            const ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h, top: 10.h),
        child: Obx(
          () => ClipRRect(
            borderRadius: BorderRadius.circular(35.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 70.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(35.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home,
                      label: 'Home',
                      index: 0,
                      currentIndex: controller.currentIndex.value,
                    ),
                    _buildNavItem(
                      icon: Icons.location_on_outlined,
                      activeIcon: Icons.location_on,
                      label: 'Map',
                      index: 1,
                      currentIndex: controller.currentIndex.value,
                    ),
                    _buildNavItem(
                      icon: Icons.shopping_cart_outlined,
                      activeIcon: Icons.shopping_cart,
                      label: 'Cart',
                      index: 2,
                      currentIndex: controller.currentIndex.value,
                    ),
                    _buildNavItem(
                      icon: Icons.person_outline,
                      activeIcon: Icons.person,
                      label: 'Profile',
                      index: 3,
                      currentIndex: controller.currentIndex.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required int currentIndex,
  }) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? AppTheme.textColor : const Color.fromARGB(255, 121, 118, 118),
            size: 30.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppTheme.textColor : const Color.fromARGB(255, 121, 118, 118),
            ),
          ),
        ],
      ),
    );
  }
}
