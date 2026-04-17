import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/banner_model.dart';
import 'package:laundry/data/models/category_model.dart';
import 'package:laundry/data/models/storage_services_model.dart';
import 'package:laundry/data/models/steals_and_dals_model.dart';
import 'package:laundry/data/repositories/category_repository.dart';
import 'package:laundry/data/repositories/banner_repository.dart';
import 'package:laundry/data/repositories/service_repository.dart';
import 'package:laundry/data/repositories/order_repository.dart';
import 'package:laundry/data/models/past_order_model.dart';
import 'package:laundry/data/models/active_order_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:laundry/core/services/storage_service.dart';
import 'package:laundry/config/constants/storage_constants.dart';

enum LocationSelectionType { current, manual }

class HomeController extends GetxController {
  final CategoryRepository _categoryRepository = Get.find<CategoryRepository>();
  final BannerRepository _bannerRepository = Get.find<BannerRepository>();
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();
  final OrderRepository _orderRepository = Get.find<OrderRepository>();

  RxBool isLoadingCategories = false.obs;
  RxList<CategoryData> categories = <CategoryData>[].obs;

  RxBool isLoadingBanners = false.obs;
  RxList<BannerData> banners = <BannerData>[].obs;

  RxBool isLoadingServices = false.obs;
  RxList<StoreServiceData> services = <StoreServiceData>[].obs;

  RxBool isLoadingAds = false.obs;
  RxList<AdData> ads = <AdData>[].obs;

  RxBool isLoadingPastOrders = false.obs;
  RxList<MyOrderData> pastOrders = <MyOrderData>[].obs;

  RxBool isLoadingActiveOrders = false.obs;
  RxList<ActiveOrder> activeOrders = <ActiveOrder>[].obs;

  // New Variables for Location & Search
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
  RxString selectedCategoryId = ''.obs;
  RxString searchTerm = ''.obs;
  RxString currentAddress = 'Select Location'.obs;
  final locationType = LocationSelectionType.current.obs;

  @override
  void onInit() {
    super.onInit();
    // Wait for first frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Helpers.showLoadingDialog();
      await getCurrentLocation(fetchInitialData: false);
      await loadInitialData(showLoader: false);
      Helpers.hideLoadingDialog();
    });
  }

  Future<void> loadInitialData({bool showLoader = true}) async {
    if (showLoader) Helpers.showLoadingDialog();
    try {
      await Future.wait([
        getCategories(),
        getBanners(),
        getStoreServices(),
        getAds(),
        getPastOrders(),
        getActiveOrders(),
      ]);
    } catch (e) {
      Helpers.showDebugLog('Error loading initial data: $e');
    } finally {
      if (showLoader) Helpers.hideLoadingDialog();
    }
  }

  Future<void> getCategories() async {
    isLoadingCategories.value = true;
    try {
      final response = await _categoryRepository.getCategories();
      if (response.statusCode == 200) {
        final categoryResponse = CategoriesResponseModel.fromJson(response.data);
        categories.value = categoryResponse.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    } finally {
      isLoadingCategories.value = false;
    }
  }

  Future<void> getBanners() async {
    isLoadingBanners.value = true;
    try {
      final response = await _bannerRepository.getBanners();
      if (response.statusCode == 200) {
        final bannerResponse = BannerResponseModel.fromJson(response.data);
        banners.value = bannerResponse.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching banners: $e');
    } finally {
      isLoadingBanners.value = false;
    }
  }

  Future<void> getStoreServices() async {
    isLoadingServices.value = true;
    try {
      final response = await _serviceRepository.getStoreServices(
        lat.value,
        lng.value,
        selectedCategoryId.value,
        searchTerm.value,
      );
      if (response.statusCode == 200) {
        final servicesResponse = StoreServiceResponseModel.fromJson(response.data);
        services.value = servicesResponse.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching services: $e');
    } finally {
      isLoadingServices.value = false;
    }
  }

  Future<void> getAds() async {
    isLoadingAds.value = true;
    try {
      final response = await _bannerRepository.getAds(lat.value, lng.value);
      if (response.statusCode == 200) {
        final adsResponse = AdsResponseModel.fromJson(response.data);
        ads.value = adsResponse.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching ads: $e');
    } finally {
      isLoadingAds.value = false;
    }
  }

  Future<void> getPastOrders() async {
    isLoadingPastOrders.value = true;
    try {
      final response = await _orderRepository.getMyOrders(pastOrders: true);
      if (response.statusCode == 200) {
        final ordersResponse = MyOrdersResponseModel.fromJson(response.data);
        pastOrders.value = ordersResponse.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching past orders: $e');
    } finally {
      isLoadingPastOrders.value = false;
    }
  }

  Future<void> getActiveOrders() async {
    isLoadingActiveOrders.value = true;
    try {
      final response = await _orderRepository.getActiveOrders();
      if (response.statusCode == 200) {
        final ordersResponse = ActiveOrdersResponse.fromJson(response.data);
        activeOrders.value = ordersResponse.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching active orders: $e');
    } finally {
      isLoadingActiveOrders.value = false;
    }
  }

  Future<void> getCurrentLocation({bool fetchInitialData = true}) async {
    if (fetchInitialData) Helpers.showLoadingDialog();
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Helpers.showCustomSnackBar('Location services are disabled.', isError: true);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Helpers.showCustomSnackBar('Location permissions are denied', isError: true);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Helpers.showCustomSnackBar(
          'Location permissions are permanently denied.',
          isError: true,
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      lat.value = position.latitude;
      lng.value = position.longitude;
      locationType.value = LocationSelectionType.current;
      currentAddress.value = "Current Location";
      
      StorageService.setDouble(StorageConstants.userLat, lat.value);
      StorageService.setDouble(StorageConstants.userLng, lng.value);
      
      if (fetchInitialData) {
        await loadInitialData(showLoader: false);
      }
    } catch (e) {
      Helpers.showDebugLog('Error getting location: $e');
    } finally {
      if (fetchInitialData) Helpers.hideLoadingDialog();
    }
  }

  void onSearch(String value) {
    searchTerm.value = value;
    getStoreServices();
  }

  void onCategorySelected(String categoryId) {
    if (selectedCategoryId.value == categoryId) {
      selectedCategoryId.value = '';
    } else {
      selectedCategoryId.value = categoryId;
    }
    getStoreServices();
  }

  void updateLocation(double newLat, double newLng, String newAddress) {
    lat.value = newLat;
    lng.value = newLng;
    currentAddress.value = newAddress;
    locationType.value = LocationSelectionType.manual;
    StorageService.setDouble(StorageConstants.userLat, lat.value);
    StorageService.setDouble(StorageConstants.userLng, lng.value);
    loadInitialData();
  }
}
