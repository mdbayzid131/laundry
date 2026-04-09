import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/config/themes/app_theme.dart';
import '../../../core/widgets/custom_back_button.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            _buildStepper(),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildOrderSummary(),
                  SizedBox(height: 20.h),
                  _buildPickupDetails(context),
                  SizedBox(height: 30.h),
                  _buildConfirmButton(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _stepItem(Icons.check, 'Service', true),
          _stepLine(true),
          _stepItem(Icons.check, 'Address', true),
          _stepLine(false),
          _stepItem(null, '3', false, label: 'Payment'),
          _stepLine(false),
          _stepItem(null, '4', false, label: 'Confirm', isLast: true),
        ],
      ),
    );
  }

  Widget _stepItem(
    IconData? icon,
    String text,
    bool isCompleted, {
    String? label,
    bool isLast = false,
  }) {
    final themeColor = isCompleted
        ? const Color(0xffB5DEEF)
        : const Color(0xffE5E7EB);
    final iconColor = isCompleted ? Colors.white : Colors.grey.shade400;

    return Column(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: themeColor),
          child: Center(
            child: icon != null
                ? Icon(icon, size: 16.sp, color: iconColor)
                : Text(
                    text,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: isCompleted ? Colors.white : Colors.grey.shade400,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label ?? text,
          style: GoogleFonts.manrope(
            fontSize: 12.sp,
            fontWeight: isCompleted || label == 'Payment'
                ? FontWeight.w500
                : FontWeight.w400,
            color: isCompleted ? const Color(0xffB5DEEF) : Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _stepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 1.5.h,
        margin: EdgeInsets.only(bottom: 25.h, left: 8.w, right: 8.w),
        color: const Color(0xffE5E7EB),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Obx(() {
      final cart = controller.cartData.value;
      if (cart == null) return const SizedBox();

      final items = cart.items ?? [];

      return Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Summary',
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A2530),
                  ),
                ),
                Text(
                  '${items.length} Items',
                  style: GoogleFonts.manrope(
                    fontSize: 13.sp,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
              itemBuilder: (context, index) {
                final item = items[index];
                String name = '';
                String image = '';
                String subtitle = '${item.quantity} piece';

                if (item.service != null) {
                  name = item.service?.name ?? '';
                  image = item.service?.image ?? '';
                } else if (item.bundle != null) {
                  name = item.bundle?.name ?? '';
                  image = item.bundle?.image ?? '';
                }

                return _buildSummaryItem(
                  image.isNotEmpty ? image : ImagePaths.shirtIcon,
                  name,
                  subtitle,
                  '\$${item.price}',
                  isUrl: image.isNotEmpty,
                );
              },
            ),
            SizedBox(height: 24.h),
            const Divider(height: 1, color: Color(0xffF1F5F9)),
            SizedBox(height: 20.h),
            _buildSummaryRow('Subtotal', '\$${controller.subTotal.toStringAsFixed(2)}'),
            SizedBox(height: 12.h),
            _buildSummaryRow(
              'Pickup & Delivery',
              '\$${controller.deliveryFee.toStringAsFixed(2)}',
            ),
            SizedBox(height: 20.h),
            const Divider(height: 1, color: Color(0xffF1F5F9)),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1A2530),
                  ),
                ),
                Text(
                  '\$${controller.totalAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff1A2530),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSummaryItem(
    String icon,
    String title,
    String subtitle,
    String price, {
    bool isUrl = false,
  }) {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          padding: isUrl ? EdgeInsets.zero : EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xffF1F5F9)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: isUrl
                ? Image.network(icon, fit: BoxFit.cover)
                : SvgPicture.asset(
                    icon,
                    colorFilter: const ColorFilter.mode(
                      Color(0xff1A2530),
                      BlendMode.srcIn,
                    ),
                  ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
        Text(
          price,
          style: GoogleFonts.manrope(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff1A2530),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String title,
    String value, {
    bool isDiscount = false,
  }) {
    final textColor = isDiscount ? const Color(0xffB5DEEF) : Colors.black87;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 15.sp,
            fontWeight: isDiscount ? FontWeight.w600 : FontWeight.w700,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPickupDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pickup',
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
              GestureDetector(
                onTap: () => _showPickupEditDialog(context),
                child: Text(
                  'Edit',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    color: Colors.black45,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Obx(() => _buildInfoRow(
                Icons.calendar_month,
                controller.formattedDay,
                controller.formattedDate,
              )),
          SizedBox(height: 20.h),
          Obx(() => _buildInfoRow(
                Icons.access_time_filled,
                controller.formattedTime,
                'Pickup window',
              )),
          SizedBox(height: 20.h),
          Obx(() => _buildInfoRow(
                Icons.location_on,
                controller.address.value,
                controller.fullAddress,
              )),
        ],
      ),
    );
  }

  void _showPickupEditDialog(BuildContext context) {
    var selectedDate = controller.selectedDate.value;
    var selectedTime = controller.selectedTime.value;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Pickup Details',
                        style: GoogleFonts.manrope(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff1A2530),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(Icons.close, size: 24.sp, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Date Picker Field
                  Text(
                    'Pickup Date',
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xffB5DEEF),
                                onPrimary: Colors.white,
                                onSurface: Colors.black87,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setDialogState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9F9F9),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 20.sp,
                            color: Colors.black45,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            DateFormat('MMMM dd, yyyy').format(selectedDate),
                            style: GoogleFonts.manrope(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                   Text(
                    'Pickup Time',
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xffB5DEEF),
                                onPrimary: Colors.white,
                                onSurface: Colors.black87,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setDialogState(() {
                          selectedTime = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9F9F9),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 20.sp,
                            color: Colors.black45,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            selectedTime.format(context),
                            style: GoogleFonts.manrope(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updatePickupDate(selectedDate);
                        controller.updatePickupTime(selectedTime);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffB5DEEF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Update Details',
                        style: GoogleFonts.manrope(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogField(String label, String hint, {TextEditingController? controller, IconData? icon, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != 'Date' && label != 'Time') ...[
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff1A2530),
            ),
          ),
          SizedBox(height: 8.h),
        ],
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: Colors.black26,
            ),
            prefixIcon: icon != null ? Icon(icon, size: 20.sp, color: Colors.black45) : null,
            filled: true,
            fillColor: const Color(0xffF9F9F9),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: const Color(0xffF9F9F9),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20.sp, color: Colors.black87),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A2530),
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xffB5DEEF),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffB5DEEF).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => Get.toNamed(AppRoutes.ORDER_ACKNOWLEDGMENT, arguments: {
          'pickupDate': controller.selectedDate.value,
          'pickupTime': controller.formattedTime,
          'streetAddress': controller.address.value,
          'city': controller.city.value,
          'state': controller.state.value,
          'zipCode': controller.zipCode.value,
        }),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
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
    );
  }
}
