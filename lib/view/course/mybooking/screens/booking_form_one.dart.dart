import 'package:flutter/material.dart';

import '../utils/appbar_booking_form.dart';
import '../utils/bottombar_bookingform.dart';
import '../utils/content_bookingformone.dart';

class BookingFormOne extends StatelessWidget {
  const BookingFormOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarBookingForm(),
      body: BookingFormContent(),
      bottomNavigationBar: BookingFormBottomBar(),
    );
  }
}
