import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:users_side_of_turf_booking/widget/portion/button.dart';

import '../../../../model/controller/formater.dart';
import '../../../../model/controller/url.dart';
import '../../../../widget/const/colors.dart';
import '../../../../widget/const/image_name.dart';
import '../../../../view_model/course/booking_controller.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../../mybooking/screens/booking/screen/booking_form_one.dart.dart';
import '../widget/turfview_appbar.dart';

class ViewTurfDetailsScreen extends StatelessWidget {
  final String turfid;

  const ViewTurfDetailsScreen({super.key, required this.turfid});

  @override
  Widget build(BuildContext context) {
    final TurfController turfController = Get.find();
    final turf = turfController.viewTurf(turfid);
    final PageController pageController = PageController();
    var opening = Formatter.timeOfDayToString(turf!.openingTime);
    var close = Formatter.timeOfDayToString(turf.closingTime);
    return Scaffold(
      appBar: TurfViewAppBar(turfid: turfid),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Carousel
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
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: turf.images.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: turf.images[index],
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
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: turf.images.length,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            dotColor: Colors.white,
                            activeDotColor: CustomColor.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                const Icon(Icons.location_on, color: CustomColor.mainColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    turf.courtLocation,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Address
            Row(
              children: [
                const Icon(Icons.access_time, color: CustomColor.mainColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    turf.is24h ? "Open 24 Hours" : '$opening to $close',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
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
            Button().borderedWhiteButton('Call', context, () {
              Url.makePhoneCall(turf.courtPhoneNumber);
            }),
            // Book now button
            Button().smallBlueButton('Book Now', context, () {
              final BookingController controller = Get.put(BookingController());
              controller.turf.value = turf;
              Get.to(() => BookingFormOne(controller: controller));
            }),
          ],
        ),
      ),
    );
  }
}
