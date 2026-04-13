import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/core/services/api_checker.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/notifecation_preferences_model.dart';
import '../../../core/services/auth_service.dart';
import '../../../config/routes/app_pages.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/repositories/address_repository.dart';
import '../../../data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find();
  final UserRepository _userRepository = Get.find<UserRepository>();
  final AddressRepository _addressRepository = Get.find<AddressRepository>();

  final RxBool isLoading = false.obs;
  final Rxn<UserData> userData = Rxn<UserData>();
  final RxList<UserAddress> addresses = <UserAddress>[].obs;
  final RxBool isAddressLoading = false.obs;
  final RxString updateAddressId = ''.obs;

  // Notification Preferences
  final Rxn<NotificationPreferenceData> notificationPreference =
      Rxn<NotificationPreferenceData>();
  final RxBool pushNotifications = true.obs;
  final RxBool smsUpdates = false.obs;
  final RxBool emailReceipts = true.obs;
  final RxBool isNotifLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfile();
      getAddresses();
      getNotificationPreferences();
    });
  }

  Future<void> getProfile({bool showDialog = false}) async {
    isLoading.value = true;
    try {
      if (showDialog) Helpers.showLoadingDialog();
      final response = await _userRepository.getProfile();
      ApiChecker.checkGetApi(response);
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

  Future<void> updateProfileImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 70, // compress image
      );

      if (image != null && userData.value?.id != null) {
        Helpers.showLoadingDialog();
        final response = await _userRepository.updateProfileImage(
          userData.value!.id!,
          image.path,
        );
        Helpers.hideLoadingDialog();
        
        ApiChecker.checkWriteApi(response);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Helpers.showCustomSnackBar('Profile image updated successfully', isError: false);
          // Refresh profile data to get the new image URL
          getProfile();
        }
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Helpers.hideLoadingDialog();
      Helpers.showCustomSnackBar('Failed to update image', isError: true);
      Helpers.showDebugLog(e.toString());
    }
  }

  Future<void> updateProfileInfo(String name, String phone) async {
    if (userData.value?.id == null) return;
    
    Helpers.showLoadingDialog();
    try {
      final body = {
        'name': name,
        'phone': phone,
      };
      final response = await _userRepository.updateProfileInfo(userData.value!.id!, body);
      Helpers.hideLoadingDialog();
      
      ApiChecker.checkWriteApi(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (Get.isDialogOpen ?? false) Get.back();
        Helpers.showCustomSnackBar('Profile updated successfully', isError: false);
        getProfile(); // Refresh profile data
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Helpers.hideLoadingDialog();
      Helpers.showCustomSnackBar('Failed to update profile', isError: true);
      Helpers.showDebugLog(e.toString());
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
      ApiChecker.checkGetApi(response);
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
      ApiChecker.checkGetApi(response);
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
      ApiChecker.checkGetApi(response);
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
      ApiChecker.checkGetApi(response);
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
      ApiChecker.checkGetApi(response);
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

  // Notification Preferences Management
  Future<void> getNotificationPreferences() async {
    isNotifLoading.value = true;
    try {
      final response = await _userRepository.getNotificationPreferences();
      ApiChecker.checkGetApi(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = NotificationPreferenceModel.fromJson(response.data);
        notificationPreference.value = data.data;
      }
    } catch (e) {
      Helpers.showDebugLog('Error fetching notification preferences: $e');
    } finally {
      isNotifLoading.value = false;
    }
  }

  Future<void> updateNotificationPreference({
    bool? push,
    bool? sms,
    bool? email,
  }) async {
    try {
      final oldData = notificationPreference.value;

      // Update ui immediately
      notificationPreference.value = NotificationPreferenceData(
        id: oldData?.id,
        userId: oldData?.userId,
        createdAt: oldData?.createdAt,
        updatedAt: oldData?.updatedAt,
        push: push ?? oldData?.push,
        sms: sms ?? oldData?.sms,
        email: email ?? oldData?.email,
      );

      final body = {
        'push': notificationPreference.value?.push,
        'sms': notificationPreference.value?.sms,
        'email': notificationPreference.value?.email,
      };

      final response = await _userRepository.updateNotificationPreferences(
        body,
      );

      ApiChecker.checkWriteApi(response);
      if (response.statusCode != 200 && response.statusCode != 201) {
        // Fallback
        notificationPreference.value = oldData;
        getNotificationPreferences();
      }
    } catch (e) {
      Helpers.showDebugLog('Error updating notification preferences: $e');
      getNotificationPreferences();
    }
  }
}
