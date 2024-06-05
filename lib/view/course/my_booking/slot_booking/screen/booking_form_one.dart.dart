import 'package:flutter/material.dart';

import '../../../../../widget/appbar/titleonly_appbar.dart';
import '../../../../../view_model/course/booking_controller.dart';
import '../widget/bottombar_bookingform.dart';
import '../widget/content_bookingformone.dart';

class BookingFormOne extends StatelessWidget {
  final BookingController controller;

  const BookingFormOne({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleOnlyAppBar(title: "Booking Form"),
      body: BookingFormContent(controller: controller),
      bottomNavigationBar: BookingFormBottomBar(
        controller: controller,
      ),
    );
  }
}
