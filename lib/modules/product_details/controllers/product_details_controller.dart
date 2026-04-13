import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/single_service_details_model.dart';
import 'package:laundry/data/repositories/cart_repository.dart';
import 'package:laundry/data/repositories/service_repository.dart';
import 'package:laundry/data/models/storage_services_model.dart';
import 'package:laundry/core/services/storage_service.dart';
import 'package:laundry/config/constants/storage_constants.dart';
import '../../home/controllers/home_controller.dart';

class ProductDetailsController extends GetxController {
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();
  final CartRepository _cartRepository = Get.find<CartRepository>();

  RxBool isLoading = false.obs;
  RxBool isAddingToCart = false.obs;
  RxBool isLoadingRelatedServices = false.obs;
  Rxn<StoreServiceDetailsData> serviceDetails = Rxn<StoreServiceDetailsData>();
  RxList<StoreServiceData> relatedServices = <StoreServiceData>[].obs;

  // Product details state
  final RxDouble basePrice = 0.0.obs;
  final RxInt quantity = 1.obs;

  // Selected addons map: Addon ID -> Boolean isSelected
  RxMap<String, bool> selectedAddons = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    print("ProductDetailsController onInit. Args: $args");
    if (args != null && args['serviceId'] != null) {
      getServiceDetails();
    }
    if (args != null && args['categoryId'] != null) {
      getRelatedServices();
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
        storeServiceId: serviceDetails.value!.id!,
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

  Future<void> getRelatedServices() async {
    final args = Get.arguments;
    print("Fetching related services. CategoryId: ${args?['categoryId']}");
    if (args == null || args['categoryId'] == null) return;

    String categoryId = args['categoryId'];
    isLoadingRelatedServices.value = true;

    double? lat = await StorageService.getDouble(StorageConstants.userLat);
    double? lng = await StorageService.getDouble(StorageConstants.userLng);

    if (lat == null || lng == null || lat == 0.0 || lng == 0.0) {
      if (Get.isRegistered<HomeController>()) {
        final homeCtrl = Get.find<HomeController>();
        lat = homeCtrl.lat.value;
        lng = homeCtrl.lng.value;
        print("Using location from HomeController: $lat, $lng");
      }
    } else {
      print("Using location from Storage: $lat, $lng");
    }

    print(
      "Requesting related services for categoryId: $categoryId at ($lat, $lng)",
    );

    try {
      final response = await _serviceRepository.getStoreServices(
        lat ?? 0.0,
        lng ?? 0.0,
        categoryId,
        '', // searchTerm
      );

      print("Related services response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        final resModel = StoreServiceResponseModel.fromJson(response.data);
        relatedServices.value = resModel.data ?? [];
        print("Fetched ${relatedServices.length} related services");

        // Remove current service from related services if present
        if (args['serviceId'] != null) {
          relatedServices.removeWhere(
            (element) => element.id == args['serviceId'],
          );
        }
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching related services: $e');
    } finally {
      isLoadingRelatedServices.value = false;
    }
  }
}
