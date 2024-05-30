import 'package:get/get.dart';

import '../../model/backend/repositories/firestore/ads_repositories.dart';
import '../../model/data_model/ads_model.dart';

class AdsController extends GetxController {
  var adsModel = AdsModel.empty().obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchAds();
  }

  Future<void> fetchAds() async {
    try {
      isLoading.value = true;
      AdsModel ads = await AdsRepository().fetchAdsList();
      adsModel.value = ads;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load ads');
    } finally {
      isLoading.value = false;
    }
  }
}
