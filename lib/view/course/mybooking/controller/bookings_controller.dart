import 'package:get/get.dart';

import '../../../../model/backend/repositories/firestore/booking_repositories.dart';
import '../../../../model/data_model/booking_model.dart'; // Import your BookingModel

class BookingsController extends GetxController {
  RxList<BookingModel> allBookings = <BookingModel>[].obs;
  RxList<BookingModel> activeBookings = <BookingModel>[].obs;
  RxList<BookingModel> canceledBookings = <BookingModel>[].obs;
  RxList<BookingModel> completedBookings = <BookingModel>[].obs;

  // Method to fetch all bookings from the database or any other data source
  Future<void> fetchAllBookings() async {
    // Implement logic to fetch all bookings from the database
    // Example:
    List<BookingModel> bookings =
        await BookingRepository().fetchAllBookingDetails();
    allBookings.value = bookings;
    separateActiveBookings();
  }

  // Method to separate active bookings from all bookings
  void separateActiveBookings() {
    activeBookings.clear();
    DateTime currentTime = DateTime.now();
    for (var booking in allBookings) {
      if (booking.status == 'pending') {
        if (booking.startTime.isAfter(currentTime)) {
          activeBookings.add(booking);
        }
      }
    }
  }

  // Method to add a new booking
  Future<void> addBooking(BookingModel booking) async {
    // Implement logic to add a new booking to the database
    // Example:
    // await yourDatabaseService.addBooking(booking);
    // Update the bookings list
    // bookings.add(booking);
  }

  // Method to update an existing booking
  Future<void> updateBooking(BookingModel booking) async {
    // Implement logic to update the booking in the database
    // Example:
    // await yourDatabaseService.updateBooking(booking);
    // Find the index of the existing booking in the list
    // int index = bookings.indexWhere((b) => b.id == booking.id);
    // Update the booking in the list
    // if (index != -1) {
    //   bookings[index] = booking;
    // }
  }

  // Method to delete a booking
  Future<void> deleteBooking(String bookingId) async {
    // Implement logic to delete the booking from the database
    // Example:
    // await yourDatabaseService.deleteBooking(bookingId);
    // Remove the booking from the list
    // bookings.removeWhere((b) => b.id == bookingId);
  }
}
