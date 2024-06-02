import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../../../model/controller/formater.dart';
import '../../../../../../widget/portion/snackbar.dart';
import '../../../../../../view_model/course/booking_controller.dart';
import 'calender.dart';
import 'time_picker_container.dart';

class BookingFormContent extends StatefulWidget {
  final BookingController controller;

  const BookingFormContent({
    super.key,
    required this.controller,
  });

  @override
  State<BookingFormContent> createState() => _BookingFormContentState();
}

class _BookingFormContentState extends State<BookingFormContent> {
  late DateTime _selectedDate = DateTime.now();
  TimeOfDay? _openingTime;
  TimeOfDay? _closingTime;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.05),
        child: Column(
          children: [
            BookingCalendar(
              onDateSelected: (selectedDate) {
                setState(() {
                  _selectedDate = selectedDate;
                  widget.controller.selectedDate.value = _selectedDate;
                  widget.controller.bookedSlots();
                });
              },
            ),
            SizedBox(height: height * 0.02),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: const Color(0xFF238C98).withOpacity(0.20),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.02, horizontal: width * 0.05),
              child: Column(
                children: [
                  const Text("Slide to check availability"),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TimeSelector(
                        title: 'From',
                        time: _openingTime,
                        onPressed: () =>
                            _selectTime(context, true, widget.controller),
                      ),
                      TimeSelector(
                        title: 'To',
                        time: _closingTime,
                        onPressed: () =>
                            _selectTime(context, false, widget.controller),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Total Price: ${Formatter.formatCurrency(widget.controller.price.value)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  TimeOfDay parseTimeFromString(
    TimeOfDay timeString,
    bool isOpening,
  ) {
    // Split the time string into hours and minutes
    int hours = timeString.hour;
    int minutes = timeString.minute;

    if (isOpening) {
      if (hours != 0) {
        hours--;
      } else {
        hours = 23;
      }
    } else {}
    return TimeOfDay(hour: hours, minute: minutes);
  }

  Future<void> _selectTime(
    context,
    bool isOpening,
    BookingController controller,
  ) async {
    if (!isOpening && _openingTime == null) {
      CustomSnackbar.showError('Please select the starting time.');
      return;
    }
    // final now = DateTime.now();
    final openingTime = !isOpening
        ? _openingTime
        : (parseTimeFromString(
            controller.turf.value.openingTime, isOpening && false));
    final closingTime = parseTimeFromString(
        controller.turf.value.closingTime, isOpening && true);
    final initialTime = isOpening ? _openingTime : _closingTime;

    final selectedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return TimePickerDialogBox(
          initialTime: initialTime ?? TimeOfDay.now(),
          isOpening: isOpening,
          closingTime: closingTime,
          openingTime: openingTime,
        );
      },
    );

    if (selectedTime != null) {
      // Check if selected time meets the condition
      if (isOpening) {
        setState(() {
          _openingTime = selectedTime;
          _closingTime = TimeOfDay(
              hour: selectedTime.hour + 1, minute: selectedTime.minute);
        });
      } else {
        final difference = selectedTime.hour - _openingTime!.hour;
        log(difference.toString());
        if (difference >= 1 && difference <= 6) {
          setState(() {
            _closingTime = selectedTime;
          });
        } else {
          if (difference < 1) {
            CustomSnackbar.showError(
                'Minimum booking duration is limited to 1 hours');
          } else {
            CustomSnackbar.showError(
                'Maximum booking duration is limited to 6 hours');
          }
        }
      }
      setState(() {
        widget.controller.startTime.value = _openingTime!;
        widget.controller.endTime.value = _closingTime!;
        widget.controller.price.value = Formatter.calculateTotalPrice(
            widget.controller.turf.value.price, _openingTime!, _closingTime!);
      });
    }
  }
}
