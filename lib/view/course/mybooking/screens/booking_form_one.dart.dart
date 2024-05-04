import 'package:flutter/material.dart';

import '../utils/calender.dart';

class BookingFormOne extends StatefulWidget {
  const BookingFormOne({Key? key}) : super(key: key);

  @override
  _BookingFormOneState createState() => _BookingFormOneState();
}

class _BookingFormOneState extends State<BookingFormOne> {
  late DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
