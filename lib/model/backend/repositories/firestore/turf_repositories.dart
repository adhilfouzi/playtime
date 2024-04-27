import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data_model/owner_model.dart'; // Assuming OwnerModel is the model for turf details
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
        turfList.add(OwnerModel.fromJson(turfData));
      }

      return turfList;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<List<OwnerModel>> searchTurf(String query) async {
    try {
      // Implement your search logic here, such as querying Firestore based on the search query
      // Example:
      QuerySnapshot turfSnapshot = await _db
          .collection("Owner")
          .where("courtName",
              isEqualTo: query) // Assuming "name" is the field to search for
          .get();

      turfList.clear();
      for (var doc in turfSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data() as Map<String, dynamic>;
        turfList.add(OwnerModel.fromJson(turfData));
      }

      return turfList;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
