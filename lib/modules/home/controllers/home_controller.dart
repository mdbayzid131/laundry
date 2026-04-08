import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:laundry/core/services/api_checker.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/category_model.dart';
import 'package:laundry/data/repositories/category_repository.dart';

class HomeController extends GetxController {
  final CategoryRepository _categoryRepository = Get.find<CategoryRepository>();

  RxBool isLoadingCategories = false.obs;
  RxList<CategoryData> categories = <CategoryData>[].obs;

  Future<void> getCategories() async {
    isLoadingCategories.value = true;
    try {
      final response = await _categoryRepository.getCategories();
      ApiChecker.checkGetApi(response);
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
}
