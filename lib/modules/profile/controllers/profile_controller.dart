import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/core/utils/helpers.dart';
import '../../../core/services/auth_service.dart';
import '../../../config/routes/app_pages.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/repositories/address_repository.dart';
import '../../../data/models/user_model.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find();
  final UserRepository _userRepository = Get.find<UserRepository>();
  final AddressRepository _addressRepository = Get.find<AddressRepository>();

  final RxBool isLoading = false.obs;
  final Rxn<UserData> userData = Rxn<UserData>();
  final RxList<UserAddress> addresses = <UserAddress>[].obs;
  final RxBool isAddressLoading = false.obs;
  final RxString updateAddressId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfile();
      getAddresses();
    });
  }

  Future<void> getProfile({bool showDialog = false}) async {
    isLoading.value = true;
    try {
      if (showDialog) Helpers.showLoadingDialog();
      final response = await _userRepository.getProfile();
      if (response.statusCode == 200) {
        final profileResponse = UserProfileResponseModel.fromJson(
          response.data,
        );
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

  // Address Management
  Future<void> getAddresses() async {
    isAddressLoading.value = true;
    try {
      final response = await _addressRepository.getAddresses();
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        addresses.value = data
            .map((json) => UserAddress.fromJson(json))
            .toList();
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching addresses: $e');
    } finally {
      isAddressLoading.value = false;
    }
  }

  Future<bool> updateAddress(String id, Map<String, dynamic> data) async {
    isAddressLoading.value = true;
    try {
      final response = await _addressRepository.updateAddress(id, data);
      Helpers.showDebugLog('Update Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
          Get.back();
        }
        getAddresses(); // Refresh list
        Helpers.showCustomSnackBar(
          'Address updated successfully',
          isError: false,
        );
        return true;
      }
      return false;
    } catch (e) {
      Helpers.showDebugLog('Error updating address: $e');
      return false;
    } finally {
      isAddressLoading.value = false;
    }
  }

  Future<void> setDefaultAddress(UserAddress address) async {
    updateAddressId.value = address.id ?? '';
    try {
      final response = await _addressRepository.setDefaultAddress(address.id!);
      if (response.statusCode == 200) {
        getAddresses();
        Helpers.showCustomSnackBar('Default address updated', isError: false);
      }
    } catch (e) {
      Helpers.showDebugLog('Error setting default address: $e');
    } finally {
      updateAddressId.value = '';
    }
  }

  Future<bool> createAddress(Map<String, dynamic> data) async {
    isAddressLoading.value = true;
    try {
      final response = await _addressRepository.createAddress(data);
      Helpers.showDebugLog('Create Status Code: ${response.statusCode}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
          Get.back();
        }
        getAddresses();
        Helpers.showCustomSnackBar(
          'Address created successfully',
          isError: false,
        );
        return true;
      }
      return false;
    } catch (e) {
      Helpers.showDebugLog('Error creating address: $e');
      return false;
    } finally {
      isAddressLoading.value = false;
    }
  }

  Future<bool> deleteAddress(String id) async {
    isAddressLoading.value = true;
    try {
      final response = await _addressRepository.deleteAddress(id);
      if (response.statusCode == 200 || response.statusCode == 204) {
        if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
          Get.back();
        }
        getAddresses();
        Helpers.showCustomSnackBar(
          'Address deleted successfully',
          isError: false,
        );
        return true;
      }
      return false;
    } catch (e) {
      Helpers.showDebugLog('Error deleting address: $e');
      return false;
    } finally {
      isAddressLoading.value = false;
    }
  }
}
