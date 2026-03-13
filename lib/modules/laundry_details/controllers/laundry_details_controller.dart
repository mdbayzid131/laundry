import 'package:get/get.dart';

class LaundryDetailsController extends GetxController {
  // Service Type Selection
  final isDelivery = true.obs;

  // Category Filtering
  final selectedCategory = 'Wash'.obs;
  final categories = ['Wash', 'Dry Clean', 'Fold','Wash1', 'Dry Clean1', 'Fold1'];

  // Tab Selection
  final activeTab = 'Most Ordered'.obs;
  final tabs = ['Most Ordered', 'Bundles', 'Extras', 'Fluff & Fold'];

  void toggleService(bool delivery) {
    isDelivery.value = delivery;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void selectTab(String tab) {
    activeTab.value = tab;
  }
}
