import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widget/appbar/titleonly_appbar.dart';
import '../../../widget/portion/button.dart';
import '../../../model/controller/validator.dart';
import '../../../widget/portion/textfield.dart';
import '../../../view_model/course/booking_controller.dart';

class BookingFormTwo extends StatelessWidget {
  final GlobalKey<FormState> _bookingFormKey = GlobalKey<FormState>();
  BookingFormTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final BookingController bookingController = Get.find();

    return Scaffold(
      appBar: const TitleOnlyAppBar(title: "Booking Form"),
      body: Form(
        key: _bookingFormKey,
        child: Column(
          children: [
            SizedBox(height: height * 0.01),
            MyTextField(
              hintText: "Aduham Ap",
              labelText: "Full Name",
              controller: bookingController.name,
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
                controller: bookingController.email),
            SizedBox(height: height * 0.01),
            MyTextField(
              hintText: "9876543210",
              labelText: "Phone Number",
              textInputAction: TextInputAction.done,
              validator: (value) => InputValidators.validatePhoneNumber(value),
              keyboardType: TextInputType.number,
              controller: bookingController.phone,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button().mainButton('Submit', context, () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_bookingFormKey.currentState!.validate()) {
                bookingController.bookTheTurf();
              }
            }),
          ],
        ),
      ),
    );
  }
}
