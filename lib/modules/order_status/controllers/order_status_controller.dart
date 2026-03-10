import 'package:get/get.dart';

class OrderStatusController extends GetxController {
  final orderID = '#LD2024001';
  final items = [
    OrderItem(name: 'Shirts', quantity: 3, price: 15.00),
    OrderItem(name: 'Pants', quantity: 2, price: 12.00),
    OrderItem(name: 'Bedsheets', quantity: 1, price: 8.00),
  ];
  final pickupLocationName = 'CleanPro Laundry';
  final pickupLocationAddress = '1234 Main St, Downtown';

  double get total => items.fold(0, (sum, item) => sum + item.price);
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({required this.name, required this.quantity, required this.price});
}
