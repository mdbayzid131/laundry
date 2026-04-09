import 'package:get/get.dart';
import '../../../data/models/store_model.dart';
import '../../../data/models/operator_category_model.dart';
import '../../../data/models/storage-servies_model.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/repositories/store_repository.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/service_repository.dart';
import '../../../core/services/storage_service.dart';
import '../../../config/constants/storage_constants.dart';
import '../../home/controllers/home_controller.dart';

class LaundryDetailsController extends GetxController {
  final StoreRepository _storeRepository = Get.find<StoreRepository>();
  final CategoryRepository _categoryRepository = Get.find<CategoryRepository>();
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();

  RxBool isLoading = false.obs;
  Rx<StoreDetailsData?> storeDetails = Rx<StoreDetailsData?>(null);
  String? storeId;
  String? operatorId;

  RxBool isLoadingCategories = false.obs;
  RxList<OperatorCategoryData> operatorCategories =
      <OperatorCategoryData>[].obs;

  RxBool isLoadingServices = false.obs;
  RxList<StoreServiceItem> allStoreServices = <StoreServiceItem>[].obs;

  // Service Type Selection
  final isDelivery = true.obs;

  // Category Filtering
  final selectedCategory = ''.obs;

  // Tab Selection
  final activeTab = 'Most Ordered'.obs;
  final tabs = ['Most Ordered', 'Bundles', 'Extras', 'Fluff & Fold'];

  List<StoreServiceItem> get filteredServices {
    if (selectedCategory.value.isEmpty) {
      return allStoreServices;
    }
    return allStoreServices.where((service) => service.service?.categoryId == selectedCategory.value).toList();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['storeId'] != null) {
        storeId = Get.arguments['storeId'];
        fetchStoreDetails();
        fetchStoreServices();
      }
      if (Get.arguments['operatorId'] != null) {
        operatorId = Get.arguments['operatorId'];
        fetchOperatorCategories();
      }
    }
  }

  Future<void> fetchStoreDetails() async {
    if (storeId == null) return;
    isLoading.value = true;

    double? lat = await StorageService.getDouble(StorageConstants.userLat);
    double? lng = await StorageService.getDouble(StorageConstants.userLng);

    if (lat == null || lng == null) {
      if (Get.isRegistered<HomeController>()) {
        final homeCtrl = Get.find<HomeController>();
        lat = homeCtrl.lat.value;
        lng = homeCtrl.lng.value;
      }
    }

    try {
      final response = await _storeRepository.getStoreDetails(
        storeId!,
        lat: lat,
        lng: lng,
      );
      if (response.statusCode == 200 && response.data != null) {
        final resModel = StoreDetailsResponseModel.fromJson(response.data);
        storeDetails.value = resModel.data;
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching store details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOperatorCategories() async {
    if (operatorId == null) return;
    isLoadingCategories.value = true;
    try {
      final response = await _categoryRepository.getOperatorCategories(
        operatorId!,
      );
      if (response.statusCode == 200 && response.data != null) {
        final resModel = OperatorCategoryResponseModel.fromJson(response.data);
        operatorCategories.value = resModel.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching operator categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  Future<void> fetchStoreServices() async {
    if (storeId == null) return;
    isLoadingServices.value = true;
    try {
      final response = await _serviceRepository.getStoreServicesByStoreId(
        storeId!,
      );
      if (response.statusCode == 200 && response.data != null) {
        final resModel = StoreServicesResponseModel.fromJson(response.data);
        allStoreServices.value = resModel.data?.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching store services: $e');
    } finally {
      isLoadingServices.value = false;
    }
  }

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
