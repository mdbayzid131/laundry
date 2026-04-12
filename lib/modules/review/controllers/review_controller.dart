import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/core/services/api_checker.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/repositories/service_repository.dart';

class ReviewController extends GetxController {
  final ServiceRepository _serviceRepository = Get.find<ServiceRepository>();

  final TextEditingController commentController = TextEditingController();
  final RxInt rating = 5.obs;
  final RxBool isLoading = false.obs;

  late String storeServiceId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['storeServiceId'] != null) {
      storeServiceId = args['storeServiceId'];
    } else {
      // Fallback or error handling
      storeServiceId = '';
    }
  }

  void setRating(int newRating) {
    rating.value = newRating;
  }

  Future<void> submitReview() async {
    if (storeServiceId.isEmpty) {
      Helpers.showCustomSnackBar('Invalid service ID', isError: true);
      return;
    }

    if (commentController.text.trim().isEmpty) {
      Helpers.showCustomSnackBar('Please write a review', isError: true);
      return;
    }

    isLoading.value = true;
    try {
      final body = {
        'storeServiceId': storeServiceId,
        'rating': rating.value,
        'comment': commentController.text.trim(),
      };

      final response = await _serviceRepository.submitReview(body);
      ApiChecker.checkWriteApi(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helpers.showCustomSnackBar(
          'Review submitted successfully!',
          isError: false,
        );
        Navigator.pop(Get.context!);
      }
    } catch (e) {
      Helpers.showDebugLog('Error submitting review: $e');
      Helpers.showCustomSnackBar(
        'An error occurred. Please try again.',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}
