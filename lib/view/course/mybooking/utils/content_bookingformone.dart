import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../utils/portion/snackbar.dart';
import '../utils/calender.dart';
import 'time_picker_container.dart';

class BookingFormContent extends StatefulWidget {
  const BookingFormContent({
    super.key,
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
    return Padding(
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
            'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: const Color(0xFF238C98).withOpacity(0.20),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text("Slide to check availability"),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TimeSelector(
                      title: 'From',
                      time: _openingTime,
                      onPressed: () => _selectTime(context, true),
                    ),
                    TimeSelector(
                      title: 'To',
                      time: _closingTime,
                      onPressed: () => _selectTime(context, false),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(context, bool isOpening) async {
    if (!isOpening && _openingTime == null) {
      CustomSnackBar.showError(context, 'Please select the starting time.');
      return;
    }

    final initialTime = isOpening ? _openingTime : _closingTime;
    final selectedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return TimePickerDialogBox(
          isOpening: isOpening,
          closingTime: const TimeOfDay(hour: 2, minute: 00),
          openingTime:
              !isOpening ? _openingTime : const TimeOfDay(hour: 5, minute: 00),
          initialTime: initialTime ?? TimeOfDay.now(),
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
            CustomSnackBar.showError(
                context, 'Minimum booking duration is limited to 1 hours');
          } else {
            CustomSnackBar.showError(
                context, 'Maximum booking duration is limited to 6 hours');
          }
        }
      }
    }
  }
}
