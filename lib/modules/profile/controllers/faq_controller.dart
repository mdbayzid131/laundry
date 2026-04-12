import 'package:get/get.dart';
import 'package:laundry/core/services/api_checker.dart';
import 'package:laundry/core/utils/helpers.dart';
import 'package:laundry/data/models/faq_model.dart';
import 'package:laundry/data/repositories/faq_repository.dart';

class FaqController extends GetxController {
  final FaqRepository _repository = Get.find<FaqRepository>();

  RxBool isLoading = false.obs;
  RxList<FaqItemData> faqsList = <FaqItemData>[].obs;
  Rxn<int> expandedIndex = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    try {
      isLoading.value = true;
      final response = await _repository.getFaqs();
      ApiChecker.checkGetApi(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final FaqModel model = FaqModel.fromJson(response.data);
        if (model.data != null) {
          faqsList.value = model.data!;
        }
      }
    } catch (e) {
      Helpers.showDebugLog(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = null;
    } else {
      expandedIndex.value = index;
    }
  }
}
