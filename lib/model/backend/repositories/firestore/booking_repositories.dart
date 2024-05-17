import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data_model/booking_model.dart';
import '../authentication/firebase_authentication.dart';
import '../authentication/firebase_exceptionhandler.dart';

class BookingRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BookingModel>> fetchAllBookingDetails() async {
    try {
      var bookingSnapshot = await _db.collectionGroup('bookings').get();

      List<BookingModel> bookingList = [];
      for (var doc in bookingSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data();
        String bookingId = doc.id; // Retrieve the document ID
        var booking = BookingModel.fromJson(turfData, bookingId);
        if (booking.userId == AuthenticationRepository().authUser!.uid) {
          bookingList.add(booking);
        }
      }

      log("Total bookings: ${bookingList.length}");
      return bookingList;
    } catch (e) {
      log("Error:fetchAllBookingDetails =>$e");
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Save booking data to Firestore
  Future<void> saveBookingRecord(BookingModel booking, String turfId) async {
    try {
      await _db
          .collection("Owner")
          .doc(turfId)
          .collection('bookings')
          .add(booking.toJson());
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
