import 'package:flutter/material.dart';
import 'package:users_side_of_turf_booking/view/course/mybooking/screens/booking_form_two.dart';

import '../../../../utils/portion/button.dart';
import '../utils/appbar_booking_form.dart';
import '../utils/calender.dart';

class BookingFormOne extends StatefulWidget {
  const BookingFormOne({super.key});

  @override
  State<BookingFormOne> createState() => _BookingFormOneState();
}

class _BookingFormOneState extends State<BookingFormOne> {
  late DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const AppbarBookingForm(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BookingCalendar(
              onDateSelected: (selectedDate) {
                setState(() {
                  _selectedDate = selectedDate;
                });
              },
            ),
            Text(
              'Selected Date: ${_selectedDate.toString()}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Button().mainButton('Next', context, () {
          // if (controller.formKey.currentState!.validate()) {
          //   controller.submit();
          // }
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BookingFormTwo()));
        }),
      ),
    );
  }
}
