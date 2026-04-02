import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import '../../../core/services/auth_service.dart';
import '../../../config/routes/app_pages.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/models/user_model.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find();
  final UserRepository _userRepository = Get.find<UserRepository>();

  final RxBool isLoading = false.obs;
  final Rxn<UserData> userData = Rxn<UserData>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfile();
    });
  }

  Future<void> getProfile({bool showDialog = true}) async {
    isLoading.value = true;
    try {
      if (showDialog) Helpers.showLoadingDialog();
      final response = await _userRepository.getProfile();
      if (response.statusCode == 200) {
        final profileResponse = UserProfileResponseModel.fromJson(response.data);
        userData.value = profileResponse.data;
      }
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    } finally {
      if (showDialog) Helpers.hideLoadingDialog();
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      Get.offAllNamed(AppRoutes.LOGIN);
    } catch (e) {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}
