import 'package:get/get.dart';
import 'package:laundry/core/services/api_checker.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/review_model.dart';
import 'package:laundry/data/repositories/service_repository.dart';

class AllReviewsController extends GetxController {
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();

  RxBool isLoading = false.obs;
  RxList<ReviewData> reviews = <ReviewData>[].obs;
  late String storeServiceId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['storeServiceId'] != null) {
      storeServiceId = args['storeServiceId'];
      getReviews();
    } else {
      storeServiceId = '';
      Helpers.showCustomSnackBar('Invalid service ID', isError: true);
    }
  }

  Future<void> getReviews() async {
    isLoading.value = true;
    try {
      final response = await _serviceRepository.getStoreServiceReviews(storeServiceId);
      ApiChecker.checkGetApi(response);
      if (response.statusCode == 200) {
        final reviewResponse = ReviewsResponseModel.fromJson(response.data);
        reviews.value = reviewResponse.data ?? [];
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching reviews: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
