import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/model/controller/validator.dart';
import 'package:users_side_of_turf_booking/utils/portion/textfield.dart';
import 'package:users_side_of_turf_booking/view/course/mybooking/screens/booking/utils/appbar_booking_form.dart';

import '../../../../../utils/portion/button.dart';
import '../../../../../view_model/course/booking_controller.dart';

class BookingFormTwo extends StatelessWidget {
  final GlobalKey<FormState> _bookingFormKey = GlobalKey<FormState>();
  BookingFormTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final BookingController controller = Get.find();
    return Scaffold(
      appBar: const AppbarBookingForm(),
      body: Form(
        key: _bookingFormKey,
        child: Column(
          children: [
            SizedBox(height: height * 0.01),
            MyTextField(
              hintText: "Aduham Ap",
              labelText: "Full Name",
              controller: controller.name,
              validator: (value) =>
                  InputValidators.validateEmpty("name", value),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: height * 0.01),
            MyTextField(
                hintText: "jhoshuatope@gmail.com",
                labelText: "Email Address",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => InputValidators.validateEmail(value),
                controller: controller.email),
            SizedBox(height: height * 0.01),
            MyTextField(
              hintText: "9876543210",
              labelText: "Phone Number",
              textInputAction: TextInputAction.done,
              validator: (value) => InputValidators.validatePhoneNumber(value),
              keyboardType: TextInputType.number,
              controller: controller.phone,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Button().mainButton('Submit', context, () {
          FocusManager.instance.primaryFocus?.unfocus();
          if (_bookingFormKey.currentState!.validate()) {
            controller.bookTheturf();
          }
        }),
      ),
    );
  }
}
