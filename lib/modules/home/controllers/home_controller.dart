import 'package:get/get.dart';
import 'package:laundry/config/constants/image_paths.dart';
import 'package:laundry/data/models/banner_model.dart';

class HomeController extends GetxController {}

class BannerController extends GetxController {
  RxBool isLoading = false.obs;
  // final RxList<BannerModel> _banners = <BannerModel>[].obs;
  // List<BannerModel> get banners => _banners;
  // // final UserProfileManageRepo _userProfileManageRepo =
  // //     Get.find<UserProfileManageRepo>();

  // @override
  // void onInit() {
  //   super.onInit();
  //   getBanners();
  // }
  // /// ===================== GET BANNERS =====================
  // Future<void> getBanners() async {
  //   isLoading.value = true;

  //   try {
  //     final Response<dynamic> response = await _userProfileManageRepo
  //         .getBanners();
  //     if (response.statusCode == 200) {
  //       BannerResponseModel bannerResponseModel = BannerResponseModel.fromJson(response.data);
  //       _banners.value = bannerResponseModel.data.banners;
  //     }

  //   } catch (e) {
  //     print(e.toString());
  //     Helpers.showErrorSnackbar(e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  List<BannerModel> banners = [
    BannerModel(
      id: '1',
      image: ImagePaths.banner3,
      title: 'Banner 1',
      description: 'Description 1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    BannerModel(
      id: '2',
      image: ImagePaths.banner3,
      title: 'Banner 2',
      description: 'Description 2',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    BannerModel(
      id: '3',
      image: ImagePaths.banner3,
      title: 'Banner 3',
      description: 'Description 3',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
}
