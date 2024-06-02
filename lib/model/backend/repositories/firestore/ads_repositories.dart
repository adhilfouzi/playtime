import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data_model/ads_model.dart';
import '../authentication/firebase_exceptionhandler.dart';

class AdsRepository {
  // Instance of FirebaseFirestore to interact with Firestore
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch the list of ads from Firestore
  Future<AdsModel> fetchAdsList() async {
    try {
      // Fetch the document containing ads information from the "Admin" collection
      var adsShot = await _db.collection("Admin").doc("Ads").get();

      // Check if the document exists and return the corresponding AdsModel
      if (adsShot.exists) {
        return AdsModel.fromJson(adsShot.data()!);
      } else {
        // If the document does not exist, return an empty AdsModel
        return AdsModel.emptyAdsModel();
      }
    } catch (e) {
      // Handle any exceptions that occur during the fetch operation
      throw ExceptionHandler.handleException(e);
    }
  }
}
