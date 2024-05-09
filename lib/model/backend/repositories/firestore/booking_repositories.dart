import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data_model/booking_model.dart';
import '../authentication/firebase_exceptionhandler.dart';

class BookingRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<BookingModel> bookingList = List.empty();

  /// Function to fetch all turf details from Firestore
  Future<List<BookingModel>> fetchAllBookingDetails() async {
    try {
      QuerySnapshot turfSnapshot = await _db.collection("Booking").get();
      bookingList.clear();

      for (var doc in turfSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data() as Map<String, dynamic>;
        bookingList.add(BookingModel.fromJson(turfData));
      }

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
