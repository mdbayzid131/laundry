import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/banner_model.dart';
import 'package:laundry/data/models/category_model.dart';
import 'package:laundry/data/models/services_model.dart';
import 'package:laundry/data/repositories/category_repository.dart';
import 'package:laundry/data/repositories/banner_repository.dart';
import 'package:laundry/data/repositories/service_repository.dart';

class HomeController extends GetxController {
  final CategoryRepository _categoryRepository = Get.find<CategoryRepository>();
  final BannerRepository _bannerRepository = Get.find<BannerRepository>();
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();

  RxBool isLoadingCategories = false.obs;
  RxList<CategoryData> categories = <CategoryData>[].obs;

  RxBool isLoadingBanners = false.obs;
  RxList<BannerData> banners = <BannerData>[].obs;

  RxBool isLoadingServices = false.obs;
  RxList<ServiceData> services = <ServiceData>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Wait for first frame to avoid "visitChildElements called during build" error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadInitialData();
    });
  }

  Future<void> loadInitialData({bool showDialog = true}) async {
    try {
      if (showDialog) Helpers.showLoadingDialog();
      // Run both parallelly
      await Future.wait([getCategories(), getBanners(), getServices()]);
    } catch (e) {
      Helpers.showDebugLog('Error loading initial data: $e');
    } finally {
      if (showDialog) Helpers.hideLoadingDialog();
    }
  }

  Future<void> getCategories() async {
    isLoadingCategories.value = true;
    try {
      final response = await _categoryRepository.getCategories();
      if (response.statusCode == 200) {
        final categoryResponse = CategoriesResponseModel.fromJson(
          response.data,
        );
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

  Future<void> getServices() async {
    isLoadingServices.value = true;
    try {
      final response = await _serviceRepository.getServices();
      if (response.statusCode == 200) {
        final servicesResponse = ServicesResponseModel.fromJson(response.data);
        services.value = servicesResponse.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching services: $e');
    } finally {
      isLoadingServices.value = false;
    }
  }
}
