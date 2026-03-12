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
                '3 Items',
                style: GoogleFonts.manrope(
                  fontSize: 13.sp,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildSummaryItem(
            ImagePaths.shirtIcon,
            'Wash & Fold',
            '5 piece',
            '\$24.50',
          ),
          SizedBox(height: 20.h),
          _buildSummaryItem(
            ImagePaths.dryCleanIcon,
            'Dry Cleaning',
            '2 items',
            '\$18.00',
          ),
          SizedBox(height: 20.h),
          _buildSummaryItem(
            ImagePaths.ironAndPressIcon,
            'Iron & Press',
            '3 items',
            '\$9.00',
          ),
          SizedBox(height: 24.h),
          const Divider(height: 1, color: Color(0xffF1F5F9)),
          SizedBox(height: 20.h),
          _buildSummaryRow('Subtotal', '\$51.50'),
          SizedBox(height: 12.h),
          _buildSummaryRow('Pickup & Delivery', '\$4.99'),
          SizedBox(height: 12.h),
          _buildSummaryRow('Discount (FIRST20)', '-\$10.30', isDiscount: true),
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
                '\$46.19',
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
  }

  Widget _buildSummaryItem(
    String svgIcon,
    String title,
    String subtitle,
    String price,
  ) {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xffF1F5F9)),
          ),
          child: SvgPicture.asset(
            svgIcon,
            colorFilter: const ColorFilter.mode(
              Color(0xff1A2530),
              BlendMode.srcIn,
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
                controller.selectedTimeSlot.value,
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
    final dateController = TextEditingController(text: controller.formattedDate);
    final addressController = TextEditingController(text: controller.address.value);
    final aptController = TextEditingController(text: controller.aptSuite.value);
    final cityController = TextEditingController(text: controller.city.value);
    final zipController = TextEditingController(text: controller.zipCode.value);
    var selectedDate = controller.selectedDate.value;
    var selectedTime = controller.selectedTimeSlot.value;

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
                          dateController.text = DateFormat('MMMM dd, yyyy').format(picked);
                        });
                      }
                    },
                    child: IgnorePointer(
                      child: _buildDialogField('Date', 'Select Date', controller: dateController, icon: Icons.calendar_today),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Time Slot Field (Dropdown)
                  Text(
                    'Pickup Time Slot',
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff1A2530),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xffF9F9F9),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.storeHours.contains(selectedTime) ? selectedTime : controller.storeHours.first,
                        isExpanded: true,
                        icon: const Icon(Icons.access_time),
                        items: controller.storeHours.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: GoogleFonts.manrope(fontSize: 14.sp)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setDialogState(() => selectedTime = newValue);
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Address Fields
                  _buildDialogField('Street Address', 'Enter street address', controller: addressController),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(child: _buildDialogField('Apt/Suite', 'Apt 12B', controller: aptController)),
                      SizedBox(width: 12.w),
                      Expanded(child: _buildDialogField('City', 'New York', controller: cityController)),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildDialogField('Zip Code', '10022', controller: zipController, keyboardType: TextInputType.number),

                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updatePickupDetails(
                          date: selectedDate,
                          time: selectedTime,
                          addr: addressController.text,
                          apt: aptController.text,
                          cty: cityController.text,
                          zip: zipController.text,
                        );
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
        onPressed: () => Get.toNamed(AppRoutes.ORDER_ACKNOWLEDGMENT),
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
