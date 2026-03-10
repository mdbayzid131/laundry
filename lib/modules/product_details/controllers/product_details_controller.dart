import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  // Product details
  final basePrice = 8.99.obs;
  final quantity = 1.obs;

  // Add-on services state
  final expressService = false.obs;
  final expressServicePrice = 2.00;

  final stainRemoval = false.obs;
  final stainRemovalPrice = 1.50;

  // Pricing breakdown
  double get totalPrice {
    double total = basePrice.value * quantity.value;
    if (expressService.value) total += expressServicePrice * quantity.value;
    if (stainRemoval.value) total += stainRemovalPrice * quantity.value;
    return total;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void toggleExpressService() {
    expressService.value = !expressService.value;
  }

  void toggleStainRemoval() {
    stainRemoval.value = !stainRemoval.value;
  }
}
