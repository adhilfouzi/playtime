import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/portion/button.dart';
import '../screens/booking_form_two.dart';

class BookingFormBottomBar extends StatelessWidget {
  const BookingFormBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.02,
      ),
      child: Button().mainButton('Next', context, () {
        Get.to(() => const BookingFormTwo());
      }),
    );
  }
}
