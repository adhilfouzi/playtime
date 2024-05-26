import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:users_side_of_turf_booking/model/controller/url.dart';
import 'package:users_side_of_turf_booking/view/course/mybooking/screens/booking/booking_form_one.dart.dart';

import '../../../../utils/const/image_name.dart';
import '../../../../view_model/course/booking_controller.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../widget/turfview_appbar.dart';

class ViewTurfDetailsScreen extends StatelessWidget {
  final String turfid;

  const ViewTurfDetailsScreen({super.key, required this.turfid});

  @override
  Widget build(BuildContext context) {
    final TurfController turfController = Get.find();
    final turf = turfController.viewTurf(turfid);

    return Scaffold(
      appBar: TurfViewAppBar(turfid: turfid),
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
                child: CachedNetworkImage(
                  imageUrl: turf!.images[1],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    ImagePath.turf,
                    fit: BoxFit.cover,
                  ),
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
                Expanded(
                  child: Text(
                    turf.courtLocation,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
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
              Url.makePhoneCall(turf.courtPhoneNumber);
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
        borderRadius: BorderRadius.circular(999), // Button corner radius
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
      shadowColor: const Color(0xFF238C98).withOpacity(0.5),
      elevation: 5,
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
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
      padding: const EdgeInsets.symmetric(vertical: 14),
      shadowColor: const Color(0xFF238C98).withOpacity(0.5),
      elevation: 5,
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}
