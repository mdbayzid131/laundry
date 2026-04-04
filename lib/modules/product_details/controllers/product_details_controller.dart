import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/single_service_details_model.dart';
import 'package:laundry/data/repositories/service_repository.dart';

class ProductDetailsController extends GetxController {
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();

  RxBool isLoading = false.obs;
  Rxn<ServiceDetailsData> serviceDetails = Rxn<ServiceDetailsData>();

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
      getServiceDetails(args['serviceId']);
    }
  }

  Future<void> getServiceDetails(String id) async {
    isLoading.value = true;
    try {
      final response = await _serviceRepository.getServiceDetails(id);
      if (response.statusCode == 200) {
        final detailsResponse = ServiceDetailsResponseModel.fromJson(response.data);
        serviceDetails.value = detailsResponse.data;
        basePrice.value = double.tryParse(serviceDetails.value?.basePrice ?? '0') ?? 0.0;
        
        // Initialize Addons
        if (serviceDetails.value?.addons != null) {
          for (var addonWrapper in serviceDetails.value!.addons!) {
            if (addonWrapper.addon?.id != null) {
              selectedAddons[addonWrapper.addon!.id!] = false;
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
    if (serviceDetails.value?.addons != null) {
      for (var addonWrapper in serviceDetails.value!.addons!) {
        final addon = addonWrapper.addon;
        if (addon != null && selectedAddons[addon.id] == true) {
          double addonPrice = double.tryParse(addon.price ?? '0') ?? 0.0;
          total += addonPrice * quantity.value;
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
}
