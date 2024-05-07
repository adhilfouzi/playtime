import 'package:flutter/material.dart';
import 'package:users_side_of_turf_booking/utils/portion/textfield.dart';
import 'package:users_side_of_turf_booking/view/course/mybooking/utils/appbar_booking_form.dart';

import '../../../../utils/portion/button.dart';

class BookingFormTwo extends StatelessWidget {
  const BookingFormTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const AppbarBookingForm(),
      body: Column(
        children: [
          SizedBox(height: height * 0.01),
          const MyTextField(
            hintText: "Aduham Ap",
            labelText: "Full Name",
          ),
          SizedBox(height: height * 0.01),
          const MyTextField(
            hintText: "jhoshuatope@gmail.com",
            labelText: "Email Address",
          ),
          SizedBox(height: height * 0.01),
          const MyTextField(
            hintText: "9876543210",
            labelText: "Phone Number",
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Button().mainButton('Submit', context, () {}),
      ),
    );
  }
}
