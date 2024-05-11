import 'package:flutter/material.dart';

import '../../../../../../utils/portion/button.dart';
import '../../../../../../view_model/course/booking_controller.dart';

class BookingFormBottomBar extends StatelessWidget {
  final BookingController controller;

  const BookingFormBottomBar({super.key, required this.controller});

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
        controller.nextWay();
      }),
    );
  }
}
