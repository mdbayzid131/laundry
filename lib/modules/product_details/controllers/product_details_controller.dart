import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/single_service_details_model.dart';
import 'package:laundry/data/repositories/cart_repository.dart';
import 'package:laundry/data/repositories/service_repository.dart';

class ProductDetailsController extends GetxController {
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();
  final CartRepository _cartRepository = Get.find<CartRepository>();

  RxBool isLoading = false.obs;
  RxBool isAddingToCart = false.obs;
  Rxn<StoreServiceDetailsData> serviceDetails = Rxn<StoreServiceDetailsData>();

  // Product details state
  final RxDouble basePrice = 0.0.obs;
  final RxInt quantity = 1.obs;

  // Selected addons map: Addon ID -> Boolean isSelected
  RxMap<String, bool> selectedAddons = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['serviceId'] != null) {
      getServiceDetails();
    }
  }

  Future<void> getServiceDetails() async {
    String storeServiceId = Get.arguments['serviceId'];
    isLoading.value = true;
    try {
      final response = await _serviceRepository.getStoreServiceDetails(
        storeServiceId,
      );
      if (response.statusCode == 200) {
        final detailsResponse = StoreServiceDetailsResponseModel.fromJson(
          response.data,
        );
        serviceDetails.value = detailsResponse.data;
        basePrice.value =
            double.tryParse(serviceDetails.value?.service?.basePrice ?? '0') ??
            0.0;

        // Initialize Addons
        if (serviceDetails.value?.service?.serviceAddons != null) {
          for (var addonWrapper
              in serviceDetails.value!.service!.serviceAddons!) {
            final addonId = addonWrapper.addon?.id;
            if (addonId != null) {
              selectedAddons[addonId] = false;
            }
          }
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching service details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Pricing breakdown
  double get totalPrice {
    double total = basePrice.value * quantity.value;
    if (serviceDetails.value?.service?.serviceAddons != null) {
      for (var addonWrapper in serviceDetails.value!.service!.serviceAddons!) {
        final addon = addonWrapper.addon;
        if (addon != null && selectedAddons[addon.id] == true) {
          double addonPrice = double.tryParse(addon.price ?? '0') ?? 0.0;
          total += addonPrice;
        }
      }
    }
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

  void toggleAddon(String addonId) {
    if (selectedAddons.containsKey(addonId)) {
      selectedAddons[addonId] = !(selectedAddons[addonId]!);
    }
  }

  Future<void> addToCart() async {
    if (serviceDetails.value == null) return;

    isAddingToCart.value = true;
    try {
      List<String> addonIds = selectedAddons.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      final response = await _cartRepository.addToCart(
        serviceId: serviceDetails.value!.serviceId!,
        quantity: quantity.value,
        addonIds: addonIds,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Helpers.showCustomSnackBar(
          'Item added to cart successfully',
          isError: false,
        );
      }
    } catch (e) {
      Helpers.showDebugLog('Error adding to cart: $e');
      Helpers.showCustomSnackBar('Could not add item to cart', isError: true);
    } finally {
      isAddingToCart.value = false;
    }
  }
}
