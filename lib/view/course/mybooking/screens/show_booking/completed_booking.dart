import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/bookings_controller.dart';
import 'utils/booking_details.dart';

class CompletedBooking extends StatelessWidget {
  final BookingsController controller;
  const CompletedBooking({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final completedBookings = controller.completedBookings;
    final width = MediaQuery.of(context).size.width;
    return Obx(() {
      if (controller.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.errorMessage.isNotEmpty) {
        return Center(
          child: Text(controller.errorMessage),
        );
      } else {
        if (completedBookings.isEmpty) {
          return const Center(
            child: Text("no bookings are available"),
          );
        } else {
          return ListView.builder(
            itemCount: completedBookings.length,
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
                        turf: completedBookings[index],
                      ),
                      SizedBox(height: height * 0.02),
                      const Text(
                        "Well Played floks",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.green,
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
    });
  }
}
