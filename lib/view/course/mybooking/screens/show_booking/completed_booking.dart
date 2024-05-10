import 'package:flutter/material.dart';

import '../../../../../utils/portion/button.dart';
import 'active_booking.dart';

class CompletedBooking extends StatelessWidget {
  const CompletedBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: 10,
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
                BookingDetails(),
                SizedBox(height: height * 0.01),
                Button().mainButton("Booking Completed", context, () {
                  // Add action for button press
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
