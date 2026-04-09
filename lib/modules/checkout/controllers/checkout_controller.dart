import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry/data/models/cart_model.dart';
import 'package:laundry/modules/profile/controllers/profile_controller.dart';

class CheckoutController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  Rxn<CartData> cartData = Rxn<CartData>();
  
  // Pickup Details
  var selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  var selectedTime = TimeOfDay.now().obs;
  
  // Dynamic address from profile
  var address = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var zipCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      cartData.value = Get.arguments['cartData'];
    }
    _setInitialAddress();
  }

  void _setInitialAddress() {
    final defaultAddr = _profileController.addresses.firstWhereOrNull((addr) => addr.isDefault == true) 
                        ?? (_profileController.addresses.isNotEmpty ? _profileController.addresses.first : null);
    
    if (defaultAddr != null) {
      address.value = defaultAddr.streetAddress ?? '';
      city.value = defaultAddr.city ?? '';
      state.value = defaultAddr.state ?? '';
      zipCode.value = defaultAddr.postalCode ?? '';
    }
  }

  String get formattedDate => DateFormat('MMMM dd, yyyy').format(selectedDate.value);
  String get formattedDay => DateFormat('EEEE').format(selectedDate.value);
  String get formattedTime => selectedTime.value.format(Get.context!);
  String get fullAddress => "${address.value}${city.value.isNotEmpty ? ', ${city.value}' : ''}${state.value.isNotEmpty ? ', ${state.value}' : ''} ${zipCode.value}";

  double get subTotal {
    double total = 0;
    final items = cartData.value?.items ?? [];
    for (var item in items) {
      total += double.tryParse(item.price ?? '0') ?? 0;
    }
    return total;
  }

  double get deliveryFee {
    return double.tryParse(cartData.value?.pickupAndDeliveryFee ?? '0') ?? 0;
  }

  double get totalAmount => subTotal + deliveryFee;

  void updatePickupDate(DateTime date) {
    selectedDate.value = date;
  }

  void updatePickupTime(TimeOfDay time) {
    selectedTime.value = time;
  }
}
