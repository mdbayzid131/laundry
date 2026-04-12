import 'package:get/get.dart';
import 'package:laundry/core/services/api_checker.dart';
import 'package:laundry/data/models/phone_support_model.dart';
import 'package:laundry/data/repositories/phone_support_repository.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneSupportController extends GetxController {
  final PhoneSupportRepository _repository = Get.find<PhoneSupportRepository>();

  RxBool isLoading = false.obs;
  Rx<PhoneSupportModel?> phoneSupportData = Rx<PhoneSupportModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchPhoneSupport();
  }

  Future<void> fetchPhoneSupport() async {
    try {
    isLoading.value = true;
    final response = await _repository.getPhoneSupport();
    ApiChecker.checkGetApi(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      phoneSupportData.value = PhoneSupportModel.fromJson(response.data);
    } 
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    }
    isLoading.value = false;
  }

  Future<void> makePhoneCall() async {
    if (phoneSupportData.value?.data != null &&
        phoneSupportData.value!.data!.isNotEmpty) {
      final String? phoneNumber = phoneSupportData.value!.data!.first.number;
      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
        try {
          final launched = await launchUrl(launchUri);
          if (!launched) {
            Helpers.showCustomSnackBar(
              "Could not launch phone dialer",
              isError: true,
            );
          }
        } catch (e) {
          Helpers.showCustomSnackBar(
            "Could not launch phone dialer",
            isError: true,
          );
        }
      }
    }
  }

  Future<void> sendEmail() async {
    if (phoneSupportData.value?.data != null &&
        phoneSupportData.value!.data!.isNotEmpty) {
      final String? email = phoneSupportData.value!.data!.first.email;
      if (email != null && email.isNotEmpty) {
        final Uri launchUri = Uri(scheme: 'mailto', path: email);
        try {
          final launched = await launchUrl(launchUri);
          if (!launched) {
            Helpers.showCustomSnackBar(
              "Could not launch email app",
              isError: true,
            );
          }
        } catch (e) {
          Helpers.showCustomSnackBar(
            "Could not launch email app",
            isError: true,
          );
        }
      }
    }
  }
}
