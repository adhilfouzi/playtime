import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data_model/owner_model.dart';
import '../authentication/firebase_exceptionhandler.dart';

class TurfRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<OwnerModel> turfList = [];

  /// Function to fetch all turf details from Firestore
  Future<List<OwnerModel>> fetchAllTurfDetails() async {
    try {
      QuerySnapshot turfSnapshot = await _db.collection("Owner").get();
      turfList.clear();

      for (var doc in turfSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data() as Map<String, dynamic>;
        var turf = OwnerModel.fromJson(turfData);
        if (turf.isRegistered && turf.isOwner) {
          turfList.add(turf);
        }
      }

      return turfList;
    } catch (e) {
      log(e.toString());
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<List<OwnerModel>> searchTurf(String query) async {
    try {
      String normalizedQuery = query.toLowerCase();

      QuerySnapshot turfSnapshot = await _db.collection("Owner").get();

      turfList.clear();
      for (var doc in turfSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data() as Map<String, dynamic>;
        final turf = OwnerModel.fromJson(turfData);
        final turfname = turf.courtName.toLowerCase();
        if (turf.isRegistered &&
            turf.isOwner &&
            turfname.contains(normalizedQuery)) {
          turfList.add(turf);
        }
      }

      return turfList;
    } catch (e) {
      log(e.toString());
      throw ExceptionHandler.handleException(e);
    }
  }
}
