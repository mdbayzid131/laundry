import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/config/themes/app_theme.dart';
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
            const HomeView(),
            Container(
              color: Colors.white,
              child: const Center(child: Text('Map View Placeholder')),
            ),
            Container(
              color: Colors.white,
              child: const Center(child: Text('Cart View Placeholder')),
            ),
            const ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.h, top: 0),
        child: Obx(
          () => Container(
            height: 70.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(40.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_outlined,
                  label: 'Home',
                  index: 0,
                  currentIndex: controller.currentIndex.value,
                ),
                _buildNavItem(
                  icon: Icons.location_on_outlined,
                  activeIcon: Icons.location_on_outlined,
                  label: 'Map',
                  index: 1,
                  currentIndex: controller.currentIndex.value,
                ),
                _buildNavItem(
                  icon: Icons.shopping_cart_outlined,
                  activeIcon: Icons.shopping_cart_outlined,
                  label: 'Cart',
                  index: 2,
                  currentIndex: controller.currentIndex.value,
                ),
                _buildNavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person_outline,
                  label: 'Profile',
                  index: 3,
                  currentIndex: controller.currentIndex.value,
                ),
              ],
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
            color: isSelected ? AppTheme.textColor : const Color(0xffB8B8B8),
            size: 30.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppTheme.textColor : const Color(0xffB8B8B8),
            ),
          ),
        ],
      ),
    );
  }
}
