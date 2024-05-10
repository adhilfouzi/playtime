import 'dart:developer';

import 'package:get/get.dart';

import '../../../../model/backend/repositories/firestore/booking_repositories.dart';
import '../../../../model/data_model/booking_model.dart';

class BookingsController extends GetxController {
  RxList<BookingModel> activeBookings = <BookingModel>[].obs;
  RxList<BookingModel> canceledBookings = <BookingModel>[].obs;
  RxList<BookingModel> completedBookings = <BookingModel>[].obs;

  final _activeLoading = false.obs;
  final _activeErrorMessage = RxString('');

  bool get isActiveLoading => _activeLoading.value;
  String get activeError => _activeErrorMessage.value;

  @override
  void onInit() {
    super.onInit();
    separateBookings();
  }

  Future<void> separateBookings() async {
    try {
      _activeErrorMessage.value = '';
      _activeLoading.value = true;
      activeBookings.clear();
      canceledBookings.clear();
      completedBookings.clear();

      List<BookingModel> bookings =
          await BookingRepository().fetchAllBookingDetails();
      DateTime currentTime = DateTime.now();

      for (var booking in bookings) {
        if (booking.status == 'approved' &&
            booking.startTime.isBefore(currentTime)) {
          completedBookings.add(booking);
        } else if (booking.status == 'canceled' ||
            booking.endTime.isBefore(currentTime)) {
          canceledBookings.add(booking);
        } else if (booking.endTime.isAfter(currentTime) &&
                booking.status == 'pending' ||
            booking.status == 'approved') {
          activeBookings.add(booking);
        }
      }

      log("Active Bookings: ${activeBookings.length}");
      log("Canceled Bookings: ${canceledBookings.length}");
      log("Completed Bookings: ${completedBookings.length}");
    } catch (e) {
      _activeErrorMessage.value = "No bookings are available";
    } finally {
      _activeLoading.value = false;
    }
  }

  Future<void> addBooking(BookingModel booking) async {
    // Implement logic to add a new booking to the database
  }

  Future<void> updateBooking(BookingModel booking) async {
    // Implement logic to update the booking in the database
  }

  Future<void> deleteBooking(String bookingId) async {
    // Implement logic to delete the booking from the database
  }
}
