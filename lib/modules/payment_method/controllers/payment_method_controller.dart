import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:laundry/core/utils/helpers.dart';

class PaymentMethodController extends GetxController {
  final selectedMethod = 'stripe'.obs;

  String? orderId;
  String? paymentUrl;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      orderId = Get.arguments['orderId'];
      paymentUrl = Get.arguments['paymentUrl'];
    }
  }

  void selectMethod(String method) => selectedMethod.value = method;

  Future<void> payNow() async {
    if (paymentUrl != null && paymentUrl!.isNotEmpty) {
      final Uri url = Uri.parse(paymentUrl!);
      try {
        if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
          Helpers.showCustomSnackBar('Could not launch payment URL');
        }
      } catch (e) {
        Helpers.showCustomSnackBar('Error launching payment: $e');
      }
    } else {
      Helpers.showCustomSnackBar('Payment URL not available');
    }
  }
}
