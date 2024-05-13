import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/portion/button.dart';
import '../../../../../view_model/course/bookings_controller.dart';
import 'utils/booking_details.dart';
import 'utils/view_booked_details.dart';

class ActiveBooking extends StatelessWidget {
  final BookingsController controller;
  const ActiveBooking({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final activeBookings = controller.activeBookings;
    Future<void> refresh() async {
      await controller.separateBookings();
    }

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
        if (activeBookings.isEmpty) {
          return RefreshIndicator(
            onRefresh: refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height - 200,
                alignment: Alignment.center,
                child: const Text("No bookings are available"),
              ),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
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
                        const Divider(), // Add Divider for visual separation
                        Button().mainButton("View Booking", context, () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ViewBookingDetails(
                                booking: activeBookings[index],
                              ); // Show the booking details dialog
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }
    });
  }
}
