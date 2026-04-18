import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/cart_model.dart';
import 'package:laundry/data/repositories/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository = Get.find<CartRepository>();

  RxBool isLoading = false.obs;
  Rxn<CartData> cartData = Rxn<CartData>();

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  Future<void> getCart() async {
    isLoading.value = true;
    try {
      final response = await _cartRepository.getMyCart();
      if (response.statusCode == 200) {
        final cartResponse = CartResponseModel.fromJson(response.data);
        cartData.value = cartResponse.data;
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching cart: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateQuantity(String cartItemId, int newQuantity) async {
    if (newQuantity < 1) return;

    // Optimistic update
    if (cartData.value != null) {
      final items = List<CartItemModel>.from(cartData.value!.items ?? []);
      final index = items.indexWhere((element) => element.id == cartItemId);
      if (index != -1) {
        items[index] = items[index].copyWith(quantity: newQuantity);
        cartData.value = cartData.value!.copyWith(items: items);
        cartData.refresh(); // Force UI update
      }
    }

    try {
      final response = await _cartRepository.updateQuantity(
        cartItemId: cartItemId,
        quantity: newQuantity,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Refresh cart to get updated prices from server
        await getCart();
      }
    } catch (e) {
      Helpers.showDebugLog('Error updating quantity: $e');
      Helpers.showCustomSnackBar('Could not update quantity');
      // Rollback if needed (though getCart will fix it)
      await getCart();
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      final response = await _cartRepository.deleteCartItem(cartItemId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helpers.showCustomSnackBar('Item removed from cart', isError: false);
        await getCart();
      }
    } catch (e) {
      Helpers.showDebugLog('Error deleting cart item: $e');
      Helpers.showCustomSnackBar('Could not remove item from cart');
    }
  }

  double get subTotal {
    double total = 0;
    final items = cartData.value?.items ?? [];
    for (var item in items) {
      double price = double.tryParse(item.price ?? '0') ?? 0;
      int quantity = item.quantity ?? 1;
      total += price * quantity;
    }
    return total;
  }

  double get totalAmount {
    double fee =
        double.tryParse(cartData.value?.pickupAndDeliveryFee ?? '0') ?? 0;
    return subTotal + fee;
  }
}
