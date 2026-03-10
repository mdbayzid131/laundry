import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  final selectedTab = 'All Orders'.obs;
  final tabs = ['All Orders', 'Completed', 'In Progress', 'Cancelled'];

  final allOrders = <OrderModel>[
    OrderModel(
      orderNo: 'LN2024001',
      date: 'Jan 15, 2024 • 2:30 PM',
      status: 'Completed',
      serviceType: 'Wash & Fold',
      itemsCount: 8,
      deliveryType: 'Regular delivery',
      price: 24.50,
    ),
    OrderModel(
      orderNo: 'LN2024002',
      date: 'Jan 12, 2024 • 10:15 AM',
      status: 'In Progress',
      serviceType: 'Dry Cleaning',
      itemsCount: 3,
      deliveryType: 'Express delivery',
      price: 45.00,
    ),
    OrderModel(
      orderNo: 'LN2024003',
      date: 'Jan 8, 2024 • 4:45 PM',
      status: 'Completed',
      serviceType: 'Premium Care',
      itemsCount: 5,
      deliveryType: 'Standard delivery',
      price: 67.25,
    ),
    OrderModel(
      orderNo: 'LN2024004',
      date: 'Jan 5, 2024 • 1:20 PM',
      status: 'Cancelled',
      serviceType: 'Wash & Fold',
      itemsCount: 12,
      deliveryType: 'Regular delivery',
      price: 36.00,
    ),
  ].obs;

  List<OrderModel> get filteredOrders {
    if (selectedTab.value == 'All Orders') return allOrders;
    return allOrders
        .where((order) => order.status == selectedTab.value)
        .toList();
  }

  void changeTab(String tab) => selectedTab.value = tab;
}

class OrderModel {
  final String orderNo;
  final String date;
  final String status;
  final String serviceType;
  final int itemsCount;
  final String deliveryType;
  final double price;

  OrderModel({
    required this.orderNo,
    required this.date,
    required this.status,
    required this.serviceType,
    required this.itemsCount,
    required this.deliveryType,
    required this.price,
  });
}
