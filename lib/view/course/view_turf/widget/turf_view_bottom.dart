import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/controller/url.dart';
import '../../../../view_model/course/booking_controller.dart';
import '../../../../widget/portion/button.dart';
import '../../mybooking/screens/booking/screen/booking_form_one.dart.dart';

class TurfBottomBar extends StatelessWidget {
  final dynamic turf;

  const TurfBottomBar({
    super.key,
    required this.turf,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Button().borderedWhiteButton('Call', context, () {
            Url.makePhoneCall(turf.courtPhoneNumber);
          }),
          Button().smallBlueButton('Book Now', context, () {
            final BookingController controller = Get.put(BookingController());
            controller.turf.value = turf;
            Get.to(() => BookingFormOne(controller: controller));
          }),
        ],
      ),
    );
  }
}
