import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data_model/user_activity_model.dart';
import '../authentication/firebase_authentication.dart';
import '../authentication/firebase_exceptionhandler.dart';

class ActivityRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<ActivityModel> fetchActivityDetails() async {
    try {
      var activitySnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository().authUser!.uid)
          .collection('Activity')
          .get();

      ActivityModel activityList = ActivityModel.empty();
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

  Future<List<String>> findTrendingTurfs({int limit = 5}) async {
    try {
      // Retrieve activities from all users
      QuerySnapshot activitySnapshot =
          await _db.collectionGroup('Activity').get();

      // Aggregate and analyze activities to identify trending turfs
      Map<String, int> turfCounts = {};
      for (var doc in activitySnapshot.docs) {
        ActivityModel activity =
            ActivityModel.fromJson(doc.data() as Map<String, dynamic>);
        for (var turfId in activity.favourite) {
          turfCounts[turfId] = (turfCounts[turfId] ?? 0) + 1;
        }
      }

      // Sort turfs by count in descending order
      var trendingTurfs = turfCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      // Extract turf IDs
      List<String> trendingTurfIds =
          trendingTurfs.map((entry) => entry.key).toList();

      // Return the top trending turf IDs
      return trendingTurfIds.take(limit).toList();
    } catch (e) {
      log("Error: findTrendingTurfs => $e");
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Add or remove a turf from user's favorite list
  Future<void> updateFavoriteTurf(String turfId, bool isFavorite) async {
    try {
      DocumentReference activityDoc = _db
          .collection("Users")
          .doc(AuthenticationRepository().authUser!.uid)
          .collection('Activity')
          .doc('favorites');

      DocumentSnapshot docSnapshot = await activityDoc.get();

      if (docSnapshot.exists) {
        // Document exists, update it
        ActivityModel activity =
            ActivityModel.fromJson(docSnapshot.data() as Map<String, dynamic>);

        if (isFavorite) {
          if (!activity.favourite.contains(turfId)) {
            activity.favourite.add(turfId);
          }
        } else {
          activity.favourite.remove(turfId);
        }

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

  /// Check if the turf is in the favorite list
  Future<bool> isFavoriteTurf(String turfId) async {
    try {
      var activitySnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository().authUser!.uid)
          .collection('Activity')
          .doc('favorites')
          .get();

      if (activitySnapshot.exists) {
        List<String> favoriteList =
            List<String>.from(activitySnapshot.data()!['favourite'] ?? []);
        return favoriteList.contains(turfId);
      } else {
        return false;
      }
    } catch (e) {
      log("Error checking favorite turf: $e");
      throw ExceptionHandler.handleException(e);
    }
  }
}
