import 'package:flutter/material.dart';

import 'active_booking.dart';

class CanceledBooking extends StatelessWidget {
  const CanceledBooking({super.key});
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
                SizedBox(height: height * 0.02),
                const Text(
                  "Canceled this turf booking",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color.fromARGB(221, 255, 0, 0),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        );
      },
    );
  }
}
