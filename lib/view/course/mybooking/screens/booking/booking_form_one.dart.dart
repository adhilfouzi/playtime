import 'package:flutter/material.dart';

import '../../../../../view_model/course/booking_controller.dart';
import 'utils/appbar_booking_form.dart';
import 'utils/bottombar_bookingform.dart';
import 'utils/content_bookingformone.dart';

class BookingFormOne extends StatelessWidget {
  final BookingController controller;

  const BookingFormOne({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBookingForm(),
      body: BookingFormContent(controller: controller),
      bottomNavigationBar: BookingFormBottomBar(
        controller: controller,
      ),
    );
  }
}
