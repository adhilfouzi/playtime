import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data_model/ads_model.dart';
import '../authentication/firebase_exceptionhandler.dart';

class AdsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch ads list from Firestore
  Future<AdsModel> fetchAdsList() async {
    try {
      var adsShot = await _db.collection("Admin").doc("Ads").get();
      if (adsShot.exists) {
        return AdsModel.fromJson(adsShot.data()!);
      } else {
        return AdsModel.emptyAdsModel();
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
