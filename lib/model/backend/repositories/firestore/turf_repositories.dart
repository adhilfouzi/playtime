import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data_model/owner_model.dart';
import '../authentication/firebase_exceptionhandler.dart';

class TurfRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<OwnerModel> turfList = [];

  /// Fetch all turf details from Firestore
  Future<List<OwnerModel>> fetchAllTurfDetails() async {
    try {
      // Fetch all documents in the "Owner" collection
      QuerySnapshot turfSnapshot = await _db.collection("Owner").get();

      // Clear the existing list
      turfList.clear();

      // Iterate over each document in the snapshot
      for (var doc in turfSnapshot.docs) {
        // Map the document data to a map
        Map<String, dynamic> turfData = doc.data() as Map<String, dynamic>;

        // Convert the map to an OwnerModel
        var turf = OwnerModel.fromJson(turfData);

        // Add to the list if the turf is registered and is an owner
        if (turf.isRegistered && turf.isOwner) {
          turfList.add(turf);
        }
      }

      // Return the list of turfs
      return turfList;
    } catch (e) {
      // Log the error and throw a handled exception
      log(e.toString());
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Search for turfs based on a query string
  Future<List<OwnerModel>> searchTurf(String query) async {
    try {
      // Normalize the query string to lowercase
      String normalizedQuery = query.toLowerCase();

      // Fetch all documents in the "Owner" collection
      QuerySnapshot turfSnapshot = await _db.collection("Owner").get();

      // Clear the existing list
      turfList.clear();

      // Iterate over each document in the snapshot
      for (var doc in turfSnapshot.docs) {
        // Map the document data to a map
        Map<String, dynamic> turfData = doc.data() as Map<String, dynamic>;

        // Convert the map to an OwnerModel
        final turf = OwnerModel.fromJson(turfData);

        // Normalize the turf name to lowercase
        final turfname = turf.courtName.toLowerCase();

        // Add to the list if the turf is registered, is an owner, and the name contains the query
        if (turf.isRegistered &&
            turf.isOwner &&
            turfname.contains(normalizedQuery)) {
          turfList.add(turf);
        }
      }

      // Return the list of turfs
      return turfList;
    } catch (e) {
      // Log the error and throw a handled exception
      log(e.toString());
      throw ExceptionHandler.handleException(e);
    }
  }
}
