import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../view_model/course/bookings_controller.dart';
import 'utils/booking_details.dart';

class CanceledBooking extends StatelessWidget {
  final BookingsController controller;
  const CanceledBooking({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final canceledBookings = controller.canceledBookings;
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
        if (canceledBookings.isEmpty) {
          return const Center(
            child: Text("no bookings are available"),
          );
        } else {
          return ListView.builder(
            itemCount: canceledBookings.length,
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
                        turf: canceledBookings[index],
                      ),
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
    });
  }
}
