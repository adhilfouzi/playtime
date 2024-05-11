import 'dart:developer';

import 'package:get/get.dart';

import '../../model/backend/repositories/firestore/booking_repositories.dart';
import '../../model/data_model/booking_model.dart';

class BookingsController extends GetxController {
  RxList<BookingModel> activeBookings = <BookingModel>[].obs;
  RxList<BookingModel> canceledBookings = <BookingModel>[].obs;
  RxList<BookingModel> completedBookings = <BookingModel>[].obs;

  final _isLoading = false.obs;
  final _errorMessage = RxString('');

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    separateBookings();
  }

  Future<void> separateBookings() async {
    try {
      _errorMessage.value = '';
      _isLoading.value = true;
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
            (booking.status == 'pending' || booking.status == 'approved')) {
          activeBookings.add(booking);
        }
      }

      log("Active Bookings: ${activeBookings.length}");
      log("Canceled Bookings: ${canceledBookings.length}");
      log("Completed Bookings: ${completedBookings.length}");
    } catch (e) {
      _errorMessage.value = "No bookings are available";
    } finally {
      _isLoading.value = false; // Update loading state to false
      update(); // Trigger state update
    }
  }
}
