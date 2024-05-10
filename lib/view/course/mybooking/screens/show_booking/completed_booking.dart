import 'package:flutter/material.dart';

import '../../../../../utils/portion/button.dart';
import '../../controller/bookings_controller.dart';
import 'utils/booking_details.dart';

class CompletedBooking extends StatelessWidget {
  final BookingsController controller;
  const CompletedBooking({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final activeBookings = controller.completedBookings;
    final width = MediaQuery.of(context).size.width;

    if (activeBookings.isEmpty) {
      return Center(
        child: Text("no bookings are available"),
      );
    } else {
      return ListView.builder(
        itemCount: activeBookings.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.02,
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.02),
              child: Column(
                children: [
                  BookingDetails(
                    turf: activeBookings[index],
                  ),
                  SizedBox(height: height * 0.01),
                  Button().mainButton("Booking Completed", context, () {
                    // Add action for button press
                  }),
                  SizedBox(height: height * 0.01),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
