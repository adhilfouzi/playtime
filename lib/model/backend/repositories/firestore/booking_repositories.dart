import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data_model/booking_model.dart';
import '../../../data_model/transaction_model.dart';
import '../authentication/firebase_authentication.dart';
import '../authentication/firebase_exceptionhandler.dart';

class BookingRepository {
  // Instance of FirebaseFirestore to interact with Firestore
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch all booking details for the authenticated user
  Future<List<BookingModel>> fetchAllBookingDetails() async {
    try {
      // Retrieve all bookings from the 'bookings' collection group
      var bookingSnapshot = await _db.collectionGroup('bookings').get();

      List<BookingModel> bookingList = [];
      final userId = AuthenticationRepository().authUser!.uid;

      // Process each booking document
      for (var doc in bookingSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data();
        String bookingId = doc.id; // Retrieve the document ID
        var booking = BookingModel.fromJson(turfData, bookingId);

        // Add booking to list if it belongs to the authenticated user
        if (booking.userId == userId) {
          bookingList.add(booking);
        }
      }

      log("Total bookings: ${bookingList.length}");
      return bookingList;
    } catch (e) {
      log("Error: fetchAllBookingDetails => $e");
      // Handle any exceptions using a custom exception handler
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Save booking data to Firestore and return the booking ID
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

  /// Save transaction data to Firestore
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

  /// Fetch bookings for a specific turf on a selected date
  Future<List<DateTime>> fetchTurfBooking(
      String id, DateTime selectedDate) async {
    try {
      var bookingSnapshot =
          await _db.collection('Owner').doc(id).collection('bookings').get();
      List<DateTime> bookingList = [];

      // Process each booking document
      for (var doc in bookingSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data();
        String bookingId = doc.id;
        final turf = BookingModel.fromJson(turfData, bookingId);
        final starting = turf.startTime;
        final ending = turf.endTime;

        // Check if the booking is on the selected date
        if (selectedDate.month == starting.month &&
            selectedDate.day == starting.day) {
          log("difference: ${(ending.hour - starting.hour)}");

          // Add booking times to list, accounting for duration
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

      return bookingList;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
