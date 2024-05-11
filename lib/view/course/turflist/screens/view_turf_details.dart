import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:users_side_of_turf_booking/view/course/mybooking/screens/booking/booking_form_one.dart.dart';

import '../../../../model/data_model/owner_model.dart';
import '../../../../view_model/course/booking_controller.dart';

class ViewTurfDetailsScreen extends StatelessWidget {
  final OwnerModel turf;
  const ViewTurfDetailsScreen({super.key, required this.turf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/image/turf_image.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Turf name
            Text(
              turf.courtName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Address
            Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFF238C98)),
                const SizedBox(width: 8),
                Text(
                  turf.courtLocation,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              turf.courtDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Call button
            whiteButton('Call', context, () {
              _makePhoneCall(turf.courtPhoneNumber);
            }),
            // Book now button
            mainButton('Book Now', context, () {
              final BookingController controller = Get.put(BookingController());
              controller.turf = turf;
              Get.to(() => BookingFormOne(controller: controller));
            }),
          ],
        ),
      ),
    );
  }

  // Function to make a phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final url = 'tel:+91$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// Function to create main button with custom style
Widget mainButton(String text, BuildContext context, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF238C98), // Text color
      minimumSize:
          Size(MediaQuery.of(context).size.width * 0.4, 50), // Button width
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999)), // Button corner radius
    ),
    child: Text(text),
  );
}

// Function to create white button with custom style
Widget whiteButton(String text, BuildContext context, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFF238C98),
      backgroundColor: Colors.white, // Text color
      minimumSize:
          Size(MediaQuery.of(context).size.width * 0.4, 50), // Button width
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999), // Button corner radius
        side: const BorderSide(color: Color(0xFF238C98)), // Button border color
      ),
    ),
    child: Text(text),
  );
}
