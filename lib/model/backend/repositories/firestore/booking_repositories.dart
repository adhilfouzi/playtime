import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:users_side_of_turf_booking/model/backend/repositories/authentication/firebase_authentication.dart';

import '../../../data_model/booking_model.dart';
import '../authentication/firebase_exceptionhandler.dart';

class BookingRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to fetch all turf details from Firestore
  Future<List<BookingModel>> fetchAllBookingDetails() async {
    try {
      QuerySnapshot turfSnapshot = await _db.collection("Booking").get();
      List<BookingModel> bookingList = [];

      for (var doc in turfSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data() as Map<String, dynamic>;
        var turf = BookingModel.fromJson(turfData);
        if (turf.userId == AuthenticationRepository().authUser!.uid) {
          bookingList.add(turf);
        }
      }
      log("all bookingList: ${bookingList.length}");
      return bookingList;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Save booking data to Firestore
  Future<void> saveBookingRecord(BookingModel booking, String turfId) async {
    try {
      await _db.collection("Booking").doc(turfId).set(booking.toJson());
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
