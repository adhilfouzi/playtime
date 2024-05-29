import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:users_side_of_turf_booking/model/data_model/transaction_model.dart';

import '../../../data_model/booking_model.dart';
import '../authentication/firebase_authentication.dart';
import '../authentication/firebase_exceptionhandler.dart';

class BookingRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BookingModel>> fetchAllBookingDetails() async {
    try {
      var bookingSnapshot = await _db.collectionGroup('bookings').get();

      List<BookingModel> bookingList = [];
      final userId = AuthenticationRepository().authUser!.uid;
      for (var doc in bookingSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data();
        String bookingId = doc.id; // Retrieve the document ID
        var booking = BookingModel.fromJson(turfData, bookingId);
        if (booking.userId == userId) {
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
  Future<String> saveBookingRecord(BookingModel booking, String turfId) async {
    try {
      var book = await _db
          .collection("Owner")
          .doc(turfId)
          .collection('bookings')
          .add(booking.toJson());
      return book.id;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Save Transaction data to Firestore
  Future<void> saveTransactionRecord(
      TransactionModel transaction, String turfId) async {
    try {
      await _db
          .collection("Owner")
          .doc(turfId)
          .collection('transactions')
          .add(transaction.toJson());
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<List<DateTime>> fetchTurfBooking(
    String id,
    DateTime selectedDate,
  ) async {
    try {
      var bookingSnapshot =
          await _db.collection('Owner').doc(id).collection('bookings').get();
      List<DateTime> bookingList = [];
      for (var doc in bookingSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data();

        String bookingId = doc.id;
        final turf = BookingModel.fromJson(turfData, bookingId);
        final starting = turf.startTime;
        final ending = turf.endTime;
        if (selectedDate.month == starting.month &&
            selectedDate.day == starting.day) {
          log("differencre:${(ending.hour - starting.hour)}");
          if ((ending.hour - starting.hour) > 1) {
            for (var i = 0; i < (ending.hour - starting.hour); i++) {
              final day = DateTime(
                starting.year,
                starting.month,
                starting.day,
                (i == 0 ? starting.hour : (starting.hour + i)),
                starting.minute,
              );
              bookingList.add(day);
              log(day.toIso8601String());
            }
          } else {
            bookingList.add(starting);
          }
        }
      }

      // log("Total booking Request: ${bookingList.length}");
      return bookingList;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
