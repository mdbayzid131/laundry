import 'package:get/get.dart';

class OrderAcknowledgmentController extends GetxController {
  final checkedPockets = false.obs;
  final delicateItemsMarked = false.obs;
  final wearAndTearLiability = false.obs;

  bool get isAllChecked =>
      checkedPockets.value &&
      delicateItemsMarked.value &&
      wearAndTearLiability.value;

  void togglePockets(bool? value) => checkedPockets.value = value ?? false;
  void toggleDelicate(bool? value) =>
      delicateItemsMarked.value = value ?? false;
  void toggleLiability(bool? value) =>
      wearAndTearLiability.value = value ?? false;
}
