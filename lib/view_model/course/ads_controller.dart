import 'package:get/get.dart';

import '../../model/backend/repositories/firestore/ads_repositories.dart';
import '../../model/data_model/ads_model.dart';
import 'turf_controller.dart';
import 'usermodel_controller.dart';

class AdsController extends GetxController {
  var adsModel = AdsModel.empty().obs;
  var isLoading = false.obs;
  final turf = Get.find<TurfController>();
  final user = Get.find<UserController>();
  @override
  void onInit() {
    super.onInit();
    fetchAds();
  }

  Future<void> fetchAds() async {
    try {
      isLoading.value = true;
      AdsModel ads = await AdsRepository().fetchAdsList();
      turf.fetchTurfList();
      turf.separateBookings();
      user.getUserRecord();
      adsModel.value = ads;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load ads');
    } finally {
      isLoading.value = false;
    }
  }
}
