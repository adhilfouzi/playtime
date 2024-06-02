import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data_model/user_activity_model.dart';
import '../authentication/firebase_authentication.dart';
import '../authentication/firebase_exceptionhandler.dart';

class ActivityRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch activity details of the authenticated user
  Future<ActivityModel> fetchActivityDetails() async {
    try {
      // Fetch the activity details from the Firestore collection for the authenticated user
      var activitySnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository().authUser!.uid)
          .collection('Activity')
          .get();

      // Initialize an empty activity model
      ActivityModel activityList = ActivityModel.empty();

      // Populate the activity list from the fetched documents
      for (var doc in activitySnapshot.docs) {
        Map<String, dynamic> activityData = doc.data();
        activityList = ActivityModel.fromJson(activityData);
      }

      log("Total Activities: ${activityList.favourite.length}");
      return activityList;
    } catch (e) {
      log("Error: fetchActivityDetails => $e");
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Find trending turfs based on user activity, with a limit on the number of results
  Future<List<String>> findTrendingTurfs({int limit = 5}) async {
    try {
      // Retrieve all activities from the Firestore collection
      QuerySnapshot activitySnapshot =
          await _db.collectionGroup('Activity').get();

      // Map to hold turf IDs and their respective counts
      Map<String, int> turfCounts = {};

      // Count the occurrences of each turf in the activities
      for (var doc in activitySnapshot.docs) {
        ActivityModel activity =
            ActivityModel.fromJson(doc.data() as Map<String, dynamic>);
        for (var turfId in activity.favourite) {
          turfCounts[turfId] = (turfCounts[turfId] ?? 0) + 1;
        }
      }

      // Sort the turfs by count in descending order to find the most popular ones
      var trendingTurfs = turfCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      // Extract the turf IDs and return the top results based on the limit
      List<String> trendingTurfIds =
          trendingTurfs.map((entry) => entry.key).toList();
      return trendingTurfIds.take(limit).toList();
    } catch (e) {
      log("Error: findTrendingTurfs => $e");
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Add or remove a turf from the user's favorite list
  Future<void> updateFavoriteTurf(String turfId, bool isFavorite) async {
    try {
      // Reference to the activity document for the authenticated user
      DocumentReference activityDoc = _db
          .collection("Users")
          .doc(AuthenticationRepository().authUser!.uid)
          .collection('Activity')
          .doc('favorites');

      // Check if the document already exists
      DocumentSnapshot docSnapshot = await activityDoc.get();

      if (docSnapshot.exists) {
        // Document exists, update it
        ActivityModel activity =
            ActivityModel.fromJson(docSnapshot.data() as Map<String, dynamic>);

        if (isFavorite) {
          // Add the turf to favorites if it's not already in the list
          if (!activity.favourite.contains(turfId)) {
            activity.favourite.add(turfId);
          }
        } else {
          // Remove the turf from favorites
          activity.favourite.remove(turfId);
        }

        // Update the document in Firestore
        await activityDoc.update(activity.toJson());
      } else {
        // Document does not exist, create it
        ActivityModel activity =
            ActivityModel(favourite: isFavorite ? [turfId] : []);
        await activityDoc.set(activity.toJson());
      }

      log("Updated favorite turfs: ${isFavorite ? 'Added' : 'Removed'} $turfId");
    } catch (e) {
      log("Error updating favorite turf: $e");
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Check if a specific turf is in the user's favorite list
  Future<bool> isFavoriteTurf(String turfId) async {
    try {
      // Fetch the activity document for the authenticated user
      var activitySnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository().authUser!.uid)
          .collection('Activity')
          .doc('favorites')
          .get();

      if (activitySnapshot.exists) {
        // Extract the favorite list and check if the turf ID is present
        List<String> favoriteList =
            List<String>.from(activitySnapshot.data()!['favourite'] ?? []);
        return favoriteList.contains(turfId);
      } else {
        return false; // Document does not exist, turf is not in favorites
      }
    } catch (e) {
      log("Error checking favorite turf: $e");
      throw ExceptionHandler.handleException(e);
    }
  }
}
