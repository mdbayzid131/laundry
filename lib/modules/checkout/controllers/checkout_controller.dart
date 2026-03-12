import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutController extends GetxController {
  final count = 0.obs;

  // Pickup Details
  var selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  var selectedTimeSlot = '08:00 AM - 11:00 AM'.obs;
  var address = '425 Park Avenue'.obs;
  var aptSuite = 'Apt 12B'.obs;
  var city = 'New York'.obs;
  var state = 'NY'.obs;
  var zipCode = '10022'.obs;

  final List<String> storeHours = [
    '08:00 AM - 11:00 AM',
    '11:00 AM - 02:00 PM',
    '02:00 PM - 05:00 PM',
    '05:00 PM - 08:00 PM',
  ];

  String get formattedDate => DateFormat('MMMM dd, yyyy').format(selectedDate.value);
  String get formattedDay => DateFormat('EEEE').format(selectedDate.value);
  String get fullAddress => "${aptSuite.value}, ${address.value}, ${city.value}, ${state.value} ${zipCode.value}";

  void updatePickupDetails({
    DateTime? date,
    String? time,
    String? addr,
    String? apt,
    String? cty,
    String? st,
    String? zip,
  }) {
    if (date != null) selectedDate.value = date;
    if (time != null) selectedTimeSlot.value = time;
    if (addr != null) address.value = addr;
    if (apt != null) aptSuite.value = apt;
    if (cty != null) city.value = cty;
    if (st != null) state.value = st;
    if (zip != null) zipCode.value = zip;
  }
}
